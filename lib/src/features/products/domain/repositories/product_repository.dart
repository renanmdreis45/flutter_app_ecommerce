import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  const ProductRepository();

  ResultFuture<List<Product>> getProducts();

  ResultFuture<Product> getProductById({required String id});
}
