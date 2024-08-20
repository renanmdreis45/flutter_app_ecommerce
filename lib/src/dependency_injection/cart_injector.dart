import 'package:flutter_app_ecommerce/src/features/products/data/datasources/local/cart_local_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/repositories/cart_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/cart_repository.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/delete_cart_item.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/get_cart_list.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/insert_cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/update_quantity.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CartInjector {
  final sl = GetIt.instance;

  void call() {
    sl.registerSingleton<CartLocalDataSource>(
        CartLocalDataSourceImpl(sl<Database>()));

    sl.registerSingleton<CartRepository>(CartRepositoryImplementation(sl()));

    sl.registerSingleton<GetCartList>(GetCartList(sl<CartRepository>()));

    sl.registerSingleton<InsertCart>(InsertCart(sl<CartRepository>()));

    sl.registerSingleton<UpdateQuantity>(UpdateQuantity(sl<CartRepository>()));

    sl.registerSingleton<DeleteCartItem>(DeleteCartItem(sl<CartRepository>()));

    sl.registerLazySingleton<CartController>(
        () => CartController(sl<GetCartList>(), sl<UpdateQuantity>(), sl<DeleteCartItem>(), sl<InsertCart>()));
  }
}
