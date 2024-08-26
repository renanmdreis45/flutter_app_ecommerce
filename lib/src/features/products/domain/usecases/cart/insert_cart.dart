import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/cart_repository.dart';

class InsertCart extends UsecaseWithParams<void, Cart> {
  const InsertCart(this._repository);

  final CartRepository _repository;

  @override
  ResultVoid call(Cart params) async => _repository.insertCart(cart: params);
}
