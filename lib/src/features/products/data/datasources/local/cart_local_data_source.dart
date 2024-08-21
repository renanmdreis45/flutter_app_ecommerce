import 'dart:io' as io;
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
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    var db = await initDatabase();
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, image TEXT)');
  }

  Future<Cart> insertCart(Cart cart) async {
    await _database!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCardList() async {
    final List<Map<String, Object?>> queryResult =
        await _database!.query('cart');

    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async {
    return await _database!.update('cart', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  Future<int> deleteCartItem(int id) async {
    return await _database!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
