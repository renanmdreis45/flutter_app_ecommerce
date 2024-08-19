import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.material,
    required this.departament,
  });

  const Product.empty()
      : this(
            id: '1',
            name: '_empty.name',
            description: '_empty.description',
            category: '_empty.category',
            image: '_empty.image',
            price: '_empty.price',
            material: '_empty.material',
            departament: '_empty.departament');

  final String id;
  final String name;
  final String description;
  final String category;
  final String image;
  final String price;
  final String material;
  final String departament;

  @override
  List<Object> get props => [id, name, description];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['nome'],
        description: json['descricao'],
        category: json['categoria'],
        image: json['imagem'],
        price: json['preco'],
        material: json['material'],
        departament: json['departamento']);
  }
}
