import 'package:flutter_app_ecommerce/core/database/database.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/get_users.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/sign_in.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/datasources/local/cart_local_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/datasources/remote/product_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/repositories/cart_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/repositories/product_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/cart_repository.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/product_repository.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/delete_cart_item.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/get_cart_list.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/insert_cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/update_quantity.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_product_by_id.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_products.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/product/product_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  final database = await initDatabase();

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
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => prefs);

  sl
    ..registerFactory(() => ProductController(getProducts: sl()))
    ..registerLazySingleton(() => GetProductById(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImplementation(sl()))
    ..registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(sl()));

  sl
    ..registerFactory(() => CartController(
        getCartList: sl(),
        updateQuantity: sl(),
        deleteCartItem: sl(),
        insertCart: sl()))
    ..registerLazySingleton(() => DeleteCartItem(sl()))
    ..registerLazySingleton(() => GetCartList(sl()))
    ..registerLazySingleton(() => InsertCart(sl()))
    ..registerLazySingleton(() => UpdateQuantity(sl()))
    ..registerLazySingleton<CartRepository>(
        () => CartRepositoryImplementation(sl()))
    ..registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(sl()))
    ..registerLazySingleton(() => database);
}
