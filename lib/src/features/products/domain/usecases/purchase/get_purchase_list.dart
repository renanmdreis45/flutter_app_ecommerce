import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/purchase_repository.dart';

class GetPurchaseList extends UsecaseWithoutParams {
  const GetPurchaseList(this._repository);

  final PurchaseRepository _repository;

  @override
  ResultFuture<List<Purchase>> call() async => _repository.getPurchaseList();
}
