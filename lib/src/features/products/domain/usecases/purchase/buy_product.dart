import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/purchase_repository.dart';

class BuyProduct extends UsecaseWithParams<void, BuyProductParams> {
  const BuyProduct(this._repository);

  final PurchaseRepository _repository;

  @override
  ResultVoid call(BuyProductParams params) async => _repository.buyProduct(
      productId: params.productId,
      name: params.name,
      description: params.description,
      category: params.category,
      price: params.price,
      quantity: params.quantity,
      material: params.material,
      department: params.department,
      username: params.username);
}

class BuyProductParams extends Equatable {
  const BuyProductParams(
      {required this.productId,
      required this.name,
      required this.description,
      required this.category,
      required this.price,
      required this.quantity,
      required this.material,
      required this.department,
      required this.username});

  final String productId;
  final String name;
  final String description;
  final String category;
  final String price;
  final int quantity;
  final String material;
  final String department;
  final String username;

  @override
  List<Object> get props => [
        productId,
        name,
        description,
        category,
        price,
        quantity,
        material,
        department,
        username,
      ];
}
