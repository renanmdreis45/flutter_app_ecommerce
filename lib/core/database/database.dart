import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDatabase() async {
  io.Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path, 'cart.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId TEXT, name TEXT, description TEXT, category TEXT, price TEXT, quantity INTEGER, material TEXT, departament TEXT);'
      );
    },
  );
}
