import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/errors/failure.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/datasources/remote/product_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImplementation implements ProductRepository {
  const ProductRepositoryImplementation(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Product>> getProducts() async {
    try {
      final result = await _remoteDataSource.getProducts();
      print(result);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> getProductById({required String id}) async {
    try {
      final result = await _remoteDataSource.getProductById(id: id);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
