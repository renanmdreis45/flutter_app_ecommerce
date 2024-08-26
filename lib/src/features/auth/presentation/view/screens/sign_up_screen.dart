import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/common/app/providers/user_provider.dart';
import 'package:flutter_app_ecommerce/core/common/widgets/gradient_background.dart';
import 'package:flutter_app_ecommerce/core/common/widgets/rounded_button.dart';
import 'package:flutter_app_ecommerce/core/res/fonts.dart';
import 'package:flutter_app_ecommerce/core/res/media_res.dart';
import 'package:flutter_app_ecommerce/core/utils/core_utils.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter_app_ecommerce/src/features/auth/presentation/view/widgets/sign_up_form.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
      body: Consumer<AuthController>(builder: (context, authController, child) {
        if (authController.isLogged == true && authController.signUp == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<UserProvider>().initUser(authController.currentUser);
            Navigator.pushReplacementNamed(context, ProductsScreen.routeName);
          });
        } else if (authController.isLogged == false &&
            authController.signUp == true) {
          authController.signInHandler(
              emailController.text.trim(), passwordController.text.trim());
        } else if (authController.errorMessage.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CoreUtils.showSnackBar(context, authController.errorMessage);
          });
        }

        return GradientBackground(
          image: MediaRes.authGradientBackground,
          child: SafeArea(
              child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  'Ecommerce App',
                  style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sign up for an account',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: const Text('Already have an account?')),
                ),
                const SizedBox(
                  height: 10,
                ),
                SignUpForm(
                    emailController: emailController,
                    fullnameController: fullnameController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    formKey: formKey),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                    label: 'Sign Up',
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        authController.signUpHandler(
                            emailController.text.trim(),
                            fullnameController.text.trim(),
                            passwordController.text.trim());
                      }
                    })
              ],
            ),
          )),
        );
      }),
    );
  }
}
