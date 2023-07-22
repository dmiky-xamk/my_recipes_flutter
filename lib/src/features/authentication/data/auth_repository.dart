import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/api/api.dart';
import 'package:my_recipes/src/features/authentication/domain/app_user.dart';
import 'package:my_recipes/src/features/authentication/domain/auth_error_response.dart';
import 'package:my_recipes/src/features/authentication/domain/auth_response.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AuthRepository {
  AuthRepository(this._db);
  final RestClient _client = RestClient();

  // AppUser? _authState = AppUser(email: "test@test.com");
  AppUser? _authState;
  final StreamController<AppUser?> _authStateController =
      StreamController<AppUser?>.broadcast();
  Stream<AppUser?> get authStateChanges => _authStateController.stream;

  AppUser? get currentUser => _authState;

  final Database _db;
  final _store = StoreRef.main();

  /// Create or open a database.
  static Future<Database> createDatabase(String filename) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  }

  /// Create a [AuthRepository] with a default database.
  static Future<AuthRepository> createDefault() async {
    final db = await createDatabase('authenticated-user.db');
    return AuthRepository(db);
  }

  static const tokenKey = 'token';
  Future<void> storeToken(String token) async {
    await _store.record(tokenKey).put(_db, token);
  }

  Future<void> clearToken() async {
    await _store.record(tokenKey).delete(_db);
  }

  Future<String?> tryGetToken() async {
    return await _store.record(tokenKey).get(_db) as String?;
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final uri = Uri.https(
      "my-recipes-api-mk.herokuapp.com",
      "/api/v1/account/login",
    );

    final res = await _client.postData(
      uri: uri,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      parser: (data) => AuthResponse.fromJson(data),
      errorParser: (data) => throw AuthErrorResponse.fromJson(data),
    );
    // debugPrint("Client SignInResponse: $res");

    // TODO: Update recipes repository with the recipes we get when logging in.

    // RecipesRepository.updateCache(res.recipes);

    // debugPrint(authResponse.toString());
    // debugPrint("User: $authResponse");

    await _persistAuthState(res);
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final uri = Uri.https(
      "my-recipes-api-mk.herokuapp.com",
      "/api/v1/account/register",
    );

    final res = await _client.postData(
      uri: uri,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      parser: (data) => AuthResponse.fromJson(data),
      errorParser: (data) => throw AuthErrorResponse.fromJson(data),
    );
    // debugPrint("CreateUserResponse: $res");

    await _persistAuthState(res);
  }

  Future<bool> fetchPersistedUser() async {
    debugPrint("AuthRepository fetchCurrentUser");
    final token = await tryGetToken();
    if (token == null) {
      return false;
    }

    _client.updateToken(token);

    final uri = Uri.https(
      "my-recipes-api-mk.herokuapp.com",
      "/api/v1/account/",
    );

    debugPrint("Fetching current user...");

    final res = await _client.fetchData(
      uri: uri,
      parser: (data) => AuthResponse.fromJson(data),
      errorParser: (data) {
        _clearAuthState();
        throw AuthErrorResponse.fromJson(data);
      },
    );
    // debugPrint("Client SignInResponse: $res");
    debugPrint("Current user res; $res");

    // TODO: Update recipes repository with the recipes we get when logging in.

    // RecipesRepository.updateCache(res.recipes);

    // debugPrint(authResponse.toString());
    // debugPrint("User: $authResponse");

    // client.updateToken(res.token);
    _authState = AppUser(email: res.email);
    _authStateController.add(_authState);

    // ref.read(authRecipesProvider.notifier).update(res.recipes);

    return true;
  }

  Future<void> signOut() async {
    debugPrint("AuthRepository signOut");
    await _clearAuthState();
  }

  Future<void> _persistAuthState(AuthResponse res) async {
    _client.updateToken(res.token);
    _updateAuthState(AppUser(email: res.email));
    await storeToken(res.token);
  }

  Future<void> _clearAuthState() async {
    _client.updateToken(null);
    _updateAuthState(null);
    await clearToken();
  }

  void _updateAuthState(AppUser? user) {
    _authState = user;
    _authStateController.add(_authState);
  }
}

final fetchPersistedUserProvider = FutureProvider(
  (ref) {
    return ref.watch(authRepositoryProvider).fetchPersistedUser();
  },
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    // * Override this in the main.dart file.
    throw UnimplementedError();
  },
);

final authRepositoryStreamProvider2 = StreamProvider<AppUser?>(
  (ref) {
    return ref.watch(authRepositoryProvider).authStateChanges;
  },
);
