import 'dart:convert';

import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
        );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(id: id ?? this.id, createdAt: createdAt ?? this.createdAt, name: name ?? this.name);
  }

  DataMap toMap() => {
        'id': id,
        'createdAt': createdAt,
        'name': name,
      };
}
