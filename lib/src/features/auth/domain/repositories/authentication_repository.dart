import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({required String email, required String name, required String password});

  ResultFuture<List<User>> getUsers();

  ResultFuture<User> signIn({
    required String email,
    required String password,
  });
}
