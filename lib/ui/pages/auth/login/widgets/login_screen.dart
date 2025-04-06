import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
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
  bool _isObscuredPassword = true;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    widget.viewModel.login.listen((token, _) {
      if (token != null) context.go(Routes.build(path: "/home"));
    });

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      widget.viewModel.login.execute(LoginRequestModel(
        username: username,
        password: password,
      ));
      widget.viewModel.login.notifyListeners();
    } else {
      debugPrint("Formulário inválido");
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    Container(
                      height: 200,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Input(hintText: "Email", controller: _usernameController),
                    PasswordInput(
                      hintText: "Senha",
                      controller: _passwordController,
                    ),
                    ValueListenableBuilder(
                      valueListenable: widget.viewModel.login.errors,
                      builder: (context, value, child) {
                        if (value == null) {
                          return SizedBox();
                        } else {
                          final a = value.error as Exception;
                          return Text(a.toString());
                        }
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: widget.viewModel.login.isExecuting,
                      builder: (context, isLoading, child) {
                        if (isLoading) return DefaultLoading();

                        return Button(
                          label: "Entrar",
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          onPressed: _onLogin,
                          labelStyle:
                              Theme.of(context).primaryTextTheme.titleMedium,
                        );
                      },
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
            ),
          ],
        ),
      ),
    );
  }
}
