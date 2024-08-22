import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/services/get_product_providers.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final sl = GetIt.instance;
  final product_providers = getProviders();

  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder((context) {
        if (prefs.getBool("isLogged") ?? true) {
          final userPref = sl<SharedPreferences>().getString("user") ?? "";
          final userMap = jsonDecode(userPref);
          context.userProvider.initUser(userMap);
          return const ProductsScreen();
        }
        return LoginScreen();
      });
    case LoginScreen.routeName:
      return _pageBuilder(() => ChangeNotifierProvider(create: (_) => sl<AuthController>(), child: LoginScreen()), settings: settings);

     default:
      return _pageBuilder(
        (_) => Container(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(settings: settings, transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child), pageBuilder: (context, _, __) => page(context)),
  }
