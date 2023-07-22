import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_recipes/src/api/api_error_response.dart';
import 'package:my_recipes/src/features/recipes/data/recipes_api_error.dart';

class RecipesAPI {
  RecipesAPI({this.token});
  // final RestClient _client = RestClient();
  static const String _baseUrlHeroku = "my-recipes-api-mk.herokuapp.com";
  static const String _baseUrl = "localhost:7150";
  static const String _apiPath = "/api/v1/";

  String? token;

  Uri get recipes => _buildUrl(endPoint: "recipes");
  Uri recipe(String id) => _buildUrl(endPoint: "recipes/$id");

  Uri get login => _buildUrl(endPoint: "account/login");
  Uri get register => _buildUrl(endPoint: "account/register");
  Uri get user => _buildUrl(endPoint: "account");

  Uri _buildUrl({required String endPoint}) =>
      Uri.https(_baseUrlHeroku, "$_apiPath$endPoint");
}

typedef Parser<T> = T Function(dynamic);
typedef ErrorParser<T> = T Function(dynamic json);

enum HttpMethod { get, post, put, delete }

class RestClient {
  // RestClient(this._client);

  // final http.Client _client;

  // factory RestClient.create() {
  //   final client = http.Client();
  //   return RestClient(client);
  // }

  RestClient._internal(this._client);

  static final RestClient _singleton = RestClient._internal(http.Client());
  factory RestClient() => _singleton;
  final http.Client _client;

  void dispose() {
    _client.close();
  }

  final _defaultHeaders = <String, String>{
    'Content-Type': 'application/json',
  };

  void updateToken(String? token) {
    if (token == null) {
      _defaultHeaders.remove("Authorization");
      return;
    }
    _defaultHeaders["Authorization"] = "Bearer $token";
  }

  /// Selects the correct HTTP method and sends the request.
  Future<http.Response> _sendRequest(
    Uri uri,
    HttpMethod method,
    Map<String, String>? headers,
    Object? body,
  ) async {
    switch (method) {
      case HttpMethod.get:
        return await _client.get(uri, headers: headers);

      case HttpMethod.post:
        return await _client.post(uri, headers: headers, body: body);

      case HttpMethod.put:
        return await _client.put(uri, headers: headers, body: body);

      case HttpMethod.delete:
        return await _client.delete(uri, headers: headers);
      default:
        throw UnimplementedError("HttpMethod is not implemented: $method");
    }
  }

  Future<T> _handleRequest<T>({
    required Uri uri,
    required HttpMethod method,
    Map<String, String>? headers,
    Object? body,
    required Parser<T> parser,
    ErrorParser<T>? errorParser,
  }) async {
    try {
      debugPrint("Request: $uri");
      debugPrint("Headers: $headers");
      debugPrint("Body: $body");
      debugPrint("Method: $method");
      final response = await _sendRequest(uri, method, headers, body);

      debugPrint("Response: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");
      return await _handleResponseStatus(response, parser, errorParser);
    } on SocketException {
      throw const NoInternetConnectionException();
    }
  }

  Future<T> _handleResponseStatus<T>(
    http.Response response,
    Parser<dynamic> parser,
    ErrorParser<dynamic>? errorParser,
  ) async {
    if (response.statusCode == 200) {
      return parser(response.body);
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parser(response.body);
    } else if (response.statusCode == 401) {
      if (errorParser != null) {
        return errorParser(response.body);
      }
      throw const UnauthorizedException();
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      if (errorParser != null) {
        return errorParser(response.body);
      }
      throw ApiErrorResponse.fromJson(response.body);
    } else {
      throw const UnknownErrorException();
    }
  }

  /// Uses the [uri] to make a GET request.
  /// Allows to pass [headers] to the request.
  /// Uses the [parser] and [errorParser] to parse the response depending on the status code.
  Future<T> fetchData<T>({
    required Uri uri,
    Map<String, String>? headers,
    required Parser<T> parser,
    ErrorParser<T>? errorParser,
  }) async {
    return _handleRequest(
      uri: uri,
      method: HttpMethod.get,
      headers: {
        ..._defaultHeaders,
        ...?headers,
      },
      parser: parser,
      errorParser: errorParser,
    );
  }

  /// Uses the [uri] to make a POST request.
  /// Allows to pass [headers] to the request.
  /// Uses the [parser] and [errorParser] to parse the response depending on the status code.
  Future<T> postData<T>({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    required Parser<T> parser,
    ErrorParser<T>? errorParser,
  }) async {
    return _handleRequest(
      uri: uri,
      method: HttpMethod.post,
      headers: {
        ..._defaultHeaders,
        ...?headers,
      },
      body: body,
      parser: parser,
      errorParser: errorParser,
    );
  }

  /// Uses the [uri] to make a PUT request.
  /// Allows to pass [headers] to the request.
  /// Uses the [parser] and [errorParser] to parse the response depending on the status code.
  Future<T> putData<T>({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    required Parser<T> parser,
    ErrorParser<T>? errorParser,
  }) async {
    return _handleRequest(
      uri: uri,
      method: HttpMethod.put,
      headers: {
        ..._defaultHeaders,
        ...?headers,
      },
      body: body,
      parser: parser,
      errorParser: errorParser,
    );
  }

  /// Uses the [uri] to make a DELETE request.
  /// Allows to pass [headers] to the request.
  /// Uses the [parser] and [errorParser] to parse the response depending on the status code.
  Future<T> deleteData<T>({
    required Uri uri,
    Map<String, String>? headers,
    required Parser<T> parser,
    ErrorParser<T>? errorParser,
  }) async {
    return _handleRequest(
      uri: uri,
      method: HttpMethod.delete,
      headers: {
        ..._defaultHeaders,
        ...?headers,
      },
      parser: parser,
      errorParser: errorParser,
    );
  }
}
