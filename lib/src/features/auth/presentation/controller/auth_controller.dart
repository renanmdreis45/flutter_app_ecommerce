import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/get_users.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/sign_in.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required this.getUsers,
    required this.createUser,
    required this.signIn,
  });

  final GetUsers getUsers;
  final CreateUser createUser;
  final SignIn signIn;

  User currentUser = const User.empty();
  String errorMessage = "";
  bool isLogged = false;
  bool signUp = false;

  final prefs = GetIt.instance<SharedPreferences>();

  Future<void> signInHandler(String email, String password) async {
    final result = await signIn(SignInParams(email: email, password: password));
    
    result.fold((failure) {
      errorMessage = failure.message;
    }, (user) async {
      isLogged = true;
      signUp = false;
      currentUser = user;

      await prefs.setString("user", user);
      await prefs.setBool('isLogged', true);
    });

    Future.delayed(Duration.zero, () => notifyListeners());
  }

  Future<void> signUpHandler(String email, String name, String password) async {
    final result = await createUser(
        CreateUserParams(email: email, name: name, password: password));

    result.fold((failure) => Error(), (_) {
      signUp = true;
      isLogged = false;
    });

    Future.delayed(Duration.zero, () => notifyListeners());
  }
}
