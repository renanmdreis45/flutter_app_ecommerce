import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/common/app/providers/user_provider.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  UserProvider get userProvider => read<UserProvider>();

  User? get currentUser = userProvider.user;
}
