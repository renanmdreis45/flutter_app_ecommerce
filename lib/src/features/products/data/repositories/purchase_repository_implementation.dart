import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/errors/failure.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';

import 'package:flutter_app_ecommerce/src/features/products/data/datasources/remote/purchase_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/purchase_repository.dart';

class PurchaseRepositoryImplementation implements PurchaseRepository {
  const PurchaseRepositoryImplementation(this._remoteDataSource);

  final PurchaseRemoteDataSource _remoteDataSource;

  @override
  ResultVoid buyProduct({
    required String productId,
    required String name,
    required String description,
    required String category,
    required String price,
    required int quantity,
    required String material,
    required String departament,
  }) async {
    try {
      await _remoteDataSource.buyProduct(
          productId: productId,
          name: name,
          description: description,
          category: category,
          price: price,
          quantity: quantity,
          material: material,
          departament: departament);

      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Purchase>> getPurchaseList() async {
    try {
      final result = await _remoteDataSource.getPurchases();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
