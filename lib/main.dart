import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/dependency_injection/injector.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  final injector = Injector();
  injector.initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => getIt<ProductBloc>()..add(FetchProducts()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductsScreen(),
      ),
    );
  }
}
