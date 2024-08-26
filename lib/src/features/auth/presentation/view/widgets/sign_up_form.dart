import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/common/widgets/i_field.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.emailController,
      required this.fullnameController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController fullnameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.fullnameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 25,
          ),
          IField(
            controller: widget.emailController,
            hintText: 'Emaill address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 25,
          ),
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
                onPressed: () => setState(() {
                      obscurePassword = !obscurePassword;
                    }),
                icon: Icon(
                  obscurePassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          IField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
                onPressed: () => setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    }),
                icon: Icon(
                  obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                )),
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
