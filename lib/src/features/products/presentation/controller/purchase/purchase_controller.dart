import 'package:flutter/cupertino.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/purchase/buy_product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/purchase/get_purchase_list.dart';

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
      String departament) async {
    final result = await buyProduct(BuyProductParams(
        productId: productId,
        name: name,
        description: description,
        category: category,
        price: price,
        quantity: quantity,
        material: material,
        departament: departament));

    result.fold((failure) {
      errorMessage = failure.message;
    }, (_) {
      print("The purchase was finished successfully!");
    });

    Future.delayed(Duration.zero, () => notifyListeners());
  }

  Future<List<Purchase>> getPurchases() async {
    purchases = await getPurchaseList() as List<Purchase>;
    notifyListeners();
    return purchases;
  }
}
