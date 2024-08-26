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

const kCreateUserEndpoint = '/signup';
const kGetUsersEndpoint = '/users';
const kSignInEndpoint = '/login';

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
      final url = '$kBaseApiUrl$kCreateUserEndpoint';

      final response = await _client.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
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
      headers: {"Content-Type": "application/json"},
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
      print(email);
      print(password);

      final url = '$kBaseApiUrl$kSignInEndpoint';

      final result = await _client.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          })) as dynamic;

      var jsonResponse = jsonDecode(result.body);

      final user = jsonResponse['user'];

      // if (user) {
      //   throw const APIException(
      //       message: "Please try again later", statusCode: 505);
      // }
      return UserModel.fromMap(user);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
