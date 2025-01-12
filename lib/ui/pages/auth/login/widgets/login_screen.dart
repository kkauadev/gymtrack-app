import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/auth/login/view_models/login_viewmodel.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  ),
                  Button(
                    label: "Entrar",
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    onPressed: () => context.go(Routes.build(path: "/home")),
                    labelStyle: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Ainda não tem uma conta? ",
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: "Cadastre-se",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.push(
                                  Routes.build(path: "/signup"),
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
