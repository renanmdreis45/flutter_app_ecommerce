import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void initUser(User? user) {
    if (_user != user) _user = user;
  }

  set user(User? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, () => notifyListeners());
    }
  }
}
