import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/auth/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();


  ResultVoid createUser({required String createdAt, required String name});

  ResultFuture<List<User>> getUsers();
}
