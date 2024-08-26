import 'package:flutter/cupertino.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_products.dart';

class ProductController with ChangeNotifier {
  final GetProducts getProducts;

  List<Product>? products;

  ProductController({required this.getProducts});

  Future<void> onFetchProducts() async {
    final result = await getProducts.call();

    result.fold(
      (failure) {
        print("Falha ao carregar produtos: $failure");
      },
      (productList) {
        products = productList;
      },
    );
    notifyListeners();
  }

  void filterProductsByQuery(String query) {
    List<Product> newProducts = products!
        .where((element) => element.name.contains(query.trim()))
        .toList();

    products = newProducts;
    notifyListeners();
  }
}
