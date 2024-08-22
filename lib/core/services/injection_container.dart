import 'package:flutter_app_ecommerce/src/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/get_users.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/sign_in.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initAuth() async {
  sl
    ..registerFactory(
        () => AuthController(getUsers: sl(), createUser: sl(), signIn: sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    ..registerLazySingleton(() => http.Client());
}
