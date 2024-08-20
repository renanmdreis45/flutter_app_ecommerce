import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/product_repository.dart';

class GetProducts extends UsecaseWithoutParams<List<Product>> {
  const GetProducts(this._repository);

  final ProductRepository _repository;

  @override
  ResultFuture<List<Product>> call() async => _repository.getProducts();
}
