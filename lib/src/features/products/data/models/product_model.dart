import 'dart:convert';

import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.image,
    required super.price,
    required super.material,
    required super.departament,
  });

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(jsonDecode(source) as DataMap);

  ProductModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['nome'] as String,
          description: map['descricao'] as String,
          category: map['categoria'] as String,
          image: map['imagem'] as String,
          price: map['preco'] as String,
          material: map['material'] as String,
          departament: map['departamento'] as String,
        );

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? image,
    String? price,
    String? material,
    String? departament,
  }) {
    return ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        price: price ?? this.price,
        material: material ?? this.material,
        departament: departament ?? this.departament);
  }

  DataMap toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'image': image,
    'price': price,
    'material': material,
    'departament': departament,
  };
}
