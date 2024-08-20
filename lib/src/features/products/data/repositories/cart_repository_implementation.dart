import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/errors/failure.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/datasources/local/cart_local_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/cart_repository.dart';

class CartRepositoryImplementation implements CartRepository {
  const CartRepositoryImplementation(this._localDataSource);

  final CartLocalDataSource _localDataSource;

  @override
  ResultFuture<Cart> insertCart({required Cart cart}) async {
    try {
      final result = await _localDataSource.insertCart(cart);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Cart>> getCartList() async {
    try {
      final result = await _localDataSource.getCardList();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> updateQuantity({required Cart cart}) async {
    try {
      final result = await _localDataSource.updateQuantity(cart);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> deleteCartItem({required int id}) async {
    try {
      final result = await _localDataSource.deleteCartItem(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
