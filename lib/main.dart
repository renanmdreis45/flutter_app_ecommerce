import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/providers/providers.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await getProviders();
  runApp(MyApp(
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.providers});

  final providers;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
