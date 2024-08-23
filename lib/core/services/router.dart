import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/extensions/context_extension.dart';
import 'package:flutter_app_ecommerce/core/services/get_product_providers.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/cart_screen/cart_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final sl = GetIt.instance;
  late var productProviders;

  Future<void> getMultiProviders() async {
    productProviders = await getProviders();
  }

  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool("isLogged") ?? true) {
            final userPref = sl<SharedPreferences>().getString("user") ?? "";
            final userMap = jsonDecode(userPref);
            context.userProvider.initUser(userMap);
            return const ProductsScreen();
          }
          return ChangeNotifierProvider(
            create: (_) => sl<AuthController>(),
            child: const LoginScreen(),
          );
        },
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
          (_) => ChangeNotifierProvider(create: (_) => sl<AuthController>()),
          settings: settings);
    case ProductsScreen.routeName:
      getMultiProviders();
      return _pageBuilder(
          (_) => MultiBlocProvider(
                providers: productProviders,
                child: const ProductsScreen(),
              ),
          settings: settings);
    case CartScreen.routeName:
      getMultiProviders();
      return _pageBuilder(
          (_) => MultiBlocProvider(
              providers: productProviders, child: const CartScreen()),
          settings: settings);
    default:
      return _pageBuilder(
        (_) => Container(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, _, __) => page(context));
}
