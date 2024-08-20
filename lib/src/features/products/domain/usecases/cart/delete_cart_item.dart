import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/cart_repository.dart';

class DeleteCartItem extends UsecaseWithParams<int, int> {
  const DeleteCartItem(this._repository);

  final CartRepository _repository;

  @override
  ResultFuture<int> call(int params) async =>
      _repository.deleteCartItem(id: params);
}
