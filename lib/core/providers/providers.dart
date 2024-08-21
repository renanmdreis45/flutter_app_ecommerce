import 'package:flutter_app_ecommerce/core/database/database.dart';
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
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_products.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/product/product_controller.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> getProviders() async {
  final database = await initDatabase();

  return [
    Provider<http.Client>(
      create: (_) => http.Client(),
      dispose: (_, client) => client.close(),
    ),

    Provider<ProductRemoteDataSource>(
      create: (context) => ProductRemoteDataSourceImpl(context.read<http.Client>()),
    ),
    Provider<ProductRepository>(
      create: (context) => ProductRepositoryImplementation(
          context.read<ProductRemoteDataSource>()),
    ),
    Provider<GetProducts>(
      create: (context) => GetProducts(context.read<ProductRepository>()),
    ),
    ChangeNotifierProvider(
        create: (context) =>
            ProductController(getProducts: context.read<GetProducts>())),
    Provider<CartLocalDataSource>(
      create: (context) => CartLocalDataSourceImpl(database),
    ),
    Provider<CartRepository>(
        create: (context) => CartRepositoryImplementation(
              context.read<CartLocalDataSource>(),
            )),
    Provider<GetCartList>(
      create: (context) => GetCartList(context.read<CartRepository>()),
    ),
    Provider<UpdateQuantity>(
      create: (context) => UpdateQuantity(context.read<CartRepository>()),
    ),
    Provider<DeleteCartItem>(
        create: (context) => DeleteCartItem(
              context.read<CartRepository>(),
            )),
    Provider<InsertCart>(
      create: (context) => InsertCart(context.read<CartRepository>()),
    ),
    ChangeNotifierProvider(
        create: (context) => CartController(
            getCartList: context.read<GetCartList>(),
            updateQuantity: context.read<UpdateQuantity>(),
            deleteCartItem: context.read<DeleteCartItem>(),
            insertCart: context.read<InsertCart>()))
  ];
}
