import 'dart:convert';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';

class PurchaseModel extends Purchase {
  const PurchaseModel({
    required super.productId,
    required super.name,
    required super.description,
    required super.category,
    required super.price,
    required super.quantity,
    required super.material,
    required super.departament,
  });

  factory PurchaseModel.fromJson(String source) =>
      PurchaseModel.fromMap(jsonDecode(source) as DataMap);

  PurchaseModel.fromMap(DataMap map)
      : this(
          productId: map['id'] as String,
          name: map['nome'] as String,
          description: map['descricao'] as String,
          category: map['categoria'] as String,
          price: map['preco'].toString(),
          quantity: map['quantity'] as int,
          material: map['material'] as String,
          departament: map['departamento'] as String,
        );

  PurchaseModel copyWith({
    String? productId,
    String? name,
    String? description,
    String? category,
    String? price,
    int? quantity,
    String? material,
    String? departament,
  }) {
    return PurchaseModel(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        material: material ?? this.material,
        departament: departament ?? this.departament);
  }

  DataMap toMap() => {
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
