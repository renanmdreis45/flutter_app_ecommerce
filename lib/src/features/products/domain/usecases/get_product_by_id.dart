import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/product_repository.dart';

class GetProductById extends UsecaseWithParams<Product, String> {
  const GetProductById(this._repository);

  final ProductRepository _repository;

  @override
  ResultFuture<Product> call(String params) async => _repository.getProductById(id: params);
}
