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

  factory Purchase.fromMap(Map<String, dynamic> data) {
    return Purchase(
        productId: data['id'],
        name: data['nome'],
        description: data['descricao'],
        category: data['categoria'],
        price: data['preco'],
        quantity: data['quantity'],
        material: data['material'],
        departament: data['departamento']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'quantity': quantity,
      'material': material,
      'departament': departament,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
