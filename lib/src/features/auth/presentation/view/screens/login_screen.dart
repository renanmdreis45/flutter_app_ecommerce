import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/common/app/providers/user_provider.dart';
import 'package:flutter_app_ecommerce/core/common/app/widgets/rounded_button.dart';
import 'package:flutter_app_ecommerce/core/res/fonts.dart';
import 'package:flutter_app_ecommerce/core/res/media_res.dart';
import 'package:flutter_app_ecommerce/core/utils/core_utils.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:flutter_app_ecommerce/core/common/app/widgets/gradient_background.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/widgets/sign_in_form.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthController>(
        builder: (context, authController, child) {
          if (authController.isLogged) {
            context.read<UserProvider>().initUser(authController.currentUser);
            Navigator.pushReplacementNamed(context, ProductsScreen.routeName);
          } else {
            CoreUtils.showSnackBar(context, authController.errorMessage);
          }
          return GradientBackground(
              image: MediaRes.authGradientBackground,
              child: SafeArea(
                  child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Text(
                    'Ecommerce App',
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign in to your account',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Baseline(
                        baseline: 100,
                        baselineType: TextBaseline.alphabetic,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: const Text('Register account?')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SignInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey),
                  const SizedBox(
                    height: 50,
                  ),
                  RoundedButton(
                      label: 'Sign In',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthController>().signInHandler(
                              emailController.text.trim(),
                              passwordController.text.trim());
                        }
                      })
                ],
              )));
        },
      ),
    );
  }
}
