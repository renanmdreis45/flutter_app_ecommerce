import 'package:flutter_app_ecommerce/src/dependency_injection/cart_injector.dart';
import 'package:flutter_app_ecommerce/src/dependency_injection/product_injector.dart';

class Injector {
  Future<void> initializeDependencies() async {
    ProductInjector();
    CartInjector();
  }
}
