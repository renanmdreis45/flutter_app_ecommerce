import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/purchase/buy_product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/purchase/get_purchase_list.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseController with ChangeNotifier {
  final GetPurchaseList getPurchaseList;
  final BuyProduct buyProduct;

  String errorMessage = "";
  List<Purchase> purchases = [];
  Purchase? lastPurchase;

  PurchaseController({
    required this.getPurchaseList,
    required this.buyProduct,
  });

  Future<void> buyNewProduct(
      String productId,
      String name,
      String description,
      String category,
      String price,
      int quantity,
      String material,
      String department) async {
    final sl = GetIt.instance;

    final prefs = sl<SharedPreferences>();

    final user = prefs.getString("user")!;
   
    final result = await buyProduct.call(BuyProductParams(
        productId: productId,
        name: name,
        description: description,
        category: category,
        price: price,
        quantity: quantity,
        material: material,
        department: department,
        username: user));

    result.fold((failure) {
      errorMessage = failure.message;
    }, (_) {
      print("The purchase was finished successfully!");
    });

    notifyListeners();
  }

  Future<List<Purchase>> getPurchases() async {
    purchases = await getPurchaseList() as List<Purchase>;
    notifyListeners();
    return purchases;
  }
}
