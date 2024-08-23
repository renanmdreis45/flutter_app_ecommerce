import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/res/colours.dart';
import 'package:flutter_app_ecommerce/core/res/fonts.dart';
import 'package:flutter_app_ecommerce/core/services/get_product_providers.dart';
import 'package:flutter_app_ecommerce/core/common/app/providers/user_provider.dart';
import 'package:flutter_app_ecommerce/core/services/injection_container.dart';
import 'package:flutter_app_ecommerce/core/services/router.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAuth();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Ecommerce App',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
