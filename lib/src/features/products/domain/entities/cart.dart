import 'package:equatable/equatable.dart';

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
  int quantity;
  final String material;
  final String departament;

  @override
  List<Object> get props => [id, productId, name, description, category, image, price, quantity, material, departament];

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
        id: data['id'].toString(),
        productId: data['productId'],
        name: data['name'],
        description: data['description'],
        category: data['category'],
        image: "",
        price: double.parse(data['price']),
        quantity: data['quantity'],
        material: data['material'],
        departament: data['departament']);
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
