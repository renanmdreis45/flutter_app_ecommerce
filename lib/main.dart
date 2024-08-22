import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/services/get_product_providers.dart';
import 'package:flutter_app_ecommerce/core/common/app/providers/user_provider.dart';
import 'package:flutter_app_ecommerce/core/services/injection_container.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAuth();
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
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
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
