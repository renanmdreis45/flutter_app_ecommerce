import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async =>
      _repository.createUser(email: params.email, name: params.name, password: params.password);
}

class CreateUserParams extends Equatable {
  const CreateUserParams({required this.email, required this.name, required this.password});

  const CreateUserParams.empty() : this(email: '', name: '', password: '');

  final String email;
  final String name;
  final String password;

  @override
  List<Object> get props => [email, name, password];
}
