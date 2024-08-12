import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/auth/presentation/view/widgets/login_header_widget.dart';
import 'package:flutter_app_ecommerce/src/auth/presentation/view/widgets/login_input_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.70,
        minHeight: 10,
        maxWidth: MediaQuery.of(context).size.width * 0.95,
        minWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      child: SafeArea(
        child: Column(
          children: [
            buildLoginHeader('assets/login_header.png'),
            buildLoginInputFields()
          ],
        ),
      ),
    );
  }
}
