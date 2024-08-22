import 'dart:convert';

import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          email: map['email'] as String,
          name: map['name'] as String,
        );

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(id: id ?? this.id, email: email, name: name ?? this.name);
  }

  DataMap toMap() => {
        'id': id,
        'email': email,
        'name': name,
      };
      
}
