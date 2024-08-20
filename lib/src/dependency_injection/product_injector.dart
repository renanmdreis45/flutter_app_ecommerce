import 'package:flutter_app_ecommerce/src/features/products/data/datasources/remote/product_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/repositories/product_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/repositories/product_repository.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_product_by_id.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_products.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/bloc/product/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class ProductInjector {
  final sl = GetIt.instance;
  void call() {
    sl.registerSingleton<ProductRemoteDataSource>(
        ProductRemoteDataSourceImpl(sl<Client>()));

    sl.registerSingleton<ProductRepository>(
        ProductRepositoryImplementation(sl<ProductRemoteDataSource>()));

    sl.registerSingleton<GetProducts>(GetProducts(sl<ProductRepository>()));

    sl.registerSingleton<GetProductById>(
        GetProductById(sl<ProductRepository>()));

    sl.registerFactory<ProductBloc>(
        () => ProductBloc(getProducts: sl<GetProducts>()));
  }
}
