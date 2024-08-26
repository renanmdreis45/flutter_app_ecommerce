import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  const Purchase({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantity,
    required this.material,
    required this.departament,
  });

  final String productId;
  final String name;
  final String description;
  final String category;
  final String price;
  final int quantity;
  final String material;
  final String departament;

  @override
  List<Object> get props => [productId, name, description, category, price, quantity, material, departament];

}
