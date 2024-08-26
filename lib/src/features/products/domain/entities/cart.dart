import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Cart extends Equatable {
  Cart({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.quantity,
    required this.material,
    required this.departament,
  });

  final String id;
  final String productId;
  final String name;
  final String description;
  final String category;
  final String image;
  final double price;
  late final int quantity;
  final String material;
  final String departament;

  @override
  List<Object> get props => [id, productId, name, description, category, image, price, quantity, material, departament];

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
        id: data['id'],
        productId: data['productId'],
        name: data['nome'],
        description: data['descricao'],
        category: data['categoria'],
        image: data['imagem'],
        price: data['preco'],
        quantity: data['quantity'],
        material: data['material'],
        departament: data['departamento']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': int.parse(id),
      'productId': productId,
      'name': name,
      'description': description,
      'category': category,
      'price': price.toString(),
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
