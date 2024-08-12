import 'package:flutter_app_ecommerce/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();


  Future<Either<Exception, void>> createUser({required String createadAt, required String name});

  Future<Either<Exception, List<User>>> getUsers();
}
