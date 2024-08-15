import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async =>
      _repository.createUser(createdAt: params.createdAt, name: params.name);
}

class CreateUserParams extends Equatable {
  const CreateUserParams({required this.createdAt, required this.name});

  const CreateUserParams.empty()
      : this(createdAt: '_empty.string', name: '_empty.string');
      
  final String createdAt;
  final String name;

  @override
  List<Object> get props => [createdAt, name];
}
