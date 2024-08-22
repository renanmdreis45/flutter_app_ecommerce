import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/core/usecase/usecase.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';

class SignIn extends UsecaseWithParams<void, SignInParams> {
  const SignIn(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(SignInParams params) async =>
      _repository.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
