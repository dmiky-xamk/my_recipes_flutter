import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ShoppingListRepository {
  ShoppingListRepository(this._db);
  final Database _db;
  final _store = StoreRef.main();

  /// Create or open a database.
  static Future<Database> createDatabase(String filename) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  }

  /// Create a [ShoppingListRepository] with a default database.
  static Future<ShoppingListRepository> createDefault() async {
    final db = await createDatabase('shopping-list.db');
    return ShoppingListRepository(db);
  }

  static const shoppingListKey = 'shoppingList';

  /// Fetch the shopping list from the database.
  /// If the shopping list is not in the database, return an empty [ShoppingList].
  Future<ShoppingList> fetchShoppingList() async {
    final shoppingListJson =
        await _store.record(shoppingListKey).get(_db) as String?;

    if (shoppingListJson != null) {
      return ShoppingList.fromJson(shoppingListJson);
    } else {
      return const ShoppingList();
    }
  }

  Stream<ShoppingList> watchShoppingList() {
    final record = _store.record(shoppingListKey);

    return record.onSnapshot(_db).map((snapshot) {
      if (snapshot != null) {
        return ShoppingList.fromJson(snapshot.value.toString());
      } else {
        return const ShoppingList();
      }
    });
  }

  /// Save the shopping list to the database.
  Future<void> setShoppingList(ShoppingList shoppingList) async {
    await _store.record(shoppingListKey).put(_db, shoppingList.toJson());
  }
}

final shoppingListRepositoryProvider = Provider<ShoppingListRepository>((ref) {
  // * Override this in the main.dart file.
  throw UnimplementedError();
});
