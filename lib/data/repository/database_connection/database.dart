import 'dart:convert';

import 'package:manektech_demo/data/modal/cart_modal.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Database? _db;

  openDatabaseConnection() async {
    _db = await openDatabase('demo.db', version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE cart (id INTEGER PRIMARY KEY, product TEXT, qty INTEGER)');
    });
  }

  Database? get db => _db;

  Future<List<CartModal>> getAllCartItems() async {
    if (_db == null) {
      await openDatabaseConnection();
    }
    List<CartModal> cartItems = [];
    try {
      final result = await _db?.rawQuery('SELECT * FROM cart');
      if (result != null) {
        print(result.runtimeType.toString());
        print(result);
        cartItems = result.map((e) => CartModal.fromDb(e)).toList();
      } else {
        print('result null');
      }
    } catch (e) {
      rethrow;
    }
    return cartItems;
  }

  Future<int?> addItemToCart(CartModal cartItem) async {
    if (_db == null) {
      await openDatabaseConnection();
    }
    try {
      return await _db
          ?.rawInsert('INSERT INTO cart(product,qty) VALUES(?,?)', [json.encode(cartItem.product.toJson()), cartItem.qty]);
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> updateItemInCart(CartModal cartItem) async {
    if (_db == null) {
      await openDatabaseConnection();
    }
    try {
      return await _db?.rawInsert('UPDATE cart SET qty=? WHERE id=?', [cartItem.qty, cartItem.cartId]);
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> deleteItemFromCart(CartModal cartItem) async {
    if (_db == null) {
      await openDatabaseConnection();
    }
    try {
      return await _db?.rawInsert('DELETE FROM cart WHERE id=?', [cartItem.cartId]);
    } catch (e) {
      rethrow;
    }
  }
}
