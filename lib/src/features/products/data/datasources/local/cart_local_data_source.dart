import 'dart:io' as io;
import 'package:flutter_app_ecommerce/core/database/database.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class CartLocalDataSource {
  Future<Cart> insertCart(Cart cart);
  Future<List<Cart>> getCardList();
  Future<int> updateQuantity(Cart cart);
  Future<int> deleteCartItem(int id);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  Database? _database;

  CartLocalDataSourceImpl(this._database);

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return null;
  }

  initDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId TEXT, name TEXT, description TEXT, category TEXT, price TEXT, quantity INTEGER, material TEXT, departament TEXT);');
  }

  Future<Cart> insertCart(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCardList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    print(queryResult);
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
