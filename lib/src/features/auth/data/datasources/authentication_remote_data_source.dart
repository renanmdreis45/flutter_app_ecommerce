import 'dart:convert';

import 'package:flutter_app_ecommerce/core/utils/constants.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/models/user_model.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String email,
    required String name,
    required String password,
  });

  Future<List<User>> getUsers();

  Future<User> signIn({
    required String email,
    required String password,
  });
}

const kCreateUserEndpoint = '/user';
const kGetUsersEndpoint = '/users';
const kSignInEndpoint = '/signin';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response =
          await _client.post(Uri.parse('$kBaseApiUrl$kCreateUserEndpoint'),
              body: jsonEncode({
                'email': email,
                'name': name,
                'password': password,
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
      Uri.http(kBaseApiUrl, kGetUsersEndpoint),
    );
    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => UserModel.fromMap(userData))
        .toList();
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _client.post(Uri.parse('$kBaseApiUrl$kSignInEndpoint'),
              body: jsonEncode({
                'email': email,
                'password': password,
              }));

      final user = UserModel.fromJson(result.body);

      if (user == null) {
        throw const APIException(
            message: "Please try again later", statusCode: 505);
      }

      var userData = await _getUserData(user.id);

      return userData;

    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  Future<UserModel> _getUserData(String uid) async {
    final result =
        await _client.get(Uri.http(kBaseApiUrl, '$kGetUsersEndpoint/$uid'));
    return UserModel.fromJson(result.body);
  }
}
