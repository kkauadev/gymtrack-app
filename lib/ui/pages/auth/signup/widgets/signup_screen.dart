import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/auth/signup/view_models/signup_viewmodel.dart';

import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.viewModel});

  final SignupViewmodel viewModel;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscuredPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  Input(
                    hintText: "Email",
                    onChanged: (p0) => {},
                  ),
                  PasswordInput(
                    hintText: "Senha",
                    onChanged: (p0) => {},
                    showPassword: _isObscuredPassword,
                    onPressShowPassword: () => setState(
                      () => _isObscuredPassword = !_isObscuredPassword,
                    ),
                  ),
                  PasswordInput(
                    hintText: "Confirmar senha",
                    onChanged: (p0) => {},
                    showPassword: _isObscuredPassword,
                    onPressShowPassword: () => setState(
                      () => _isObscuredPassword = !_isObscuredPassword,
                    ),
                  ),
                  Button(
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    labelStyle: Theme.of(context).primaryTextTheme.labelLarge,
                    label: "Cadastrar",
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Já tem uma conta? ",
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: "Faça login",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push(
                                  Routes.build(path: "/login"),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
