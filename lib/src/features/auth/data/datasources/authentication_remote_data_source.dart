import 'dart:convert';

import 'package:flutter_app_ecommerce/core/constants/constants.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/models/user_model.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
  });

  Future<List<User>> getUsers();
}

const kCreateUserEndpoint = '/user';
const kGetUsersEndpoint = '/users';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
  }) async {
    try {
      final response =
          await _client.post(Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
              body: jsonEncode({
                'createdAt': createdAt,
                'name': name,
              }));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _client.get(
      Uri.http(kBaseUrl, kGetUsersEndpoint),
    );
    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => UserModel.fromMap(userData))
        .toList();
  }
}
