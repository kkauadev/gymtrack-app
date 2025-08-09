import 'package:command_it/command_it.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
import 'package:gymtrack/ui/pages/auth/login/login_viewmodel.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/input.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    widget.viewModel.login.listen((token, _) {
      if (token != null) {
        context.go(MySubscriptionsScreen.getPath());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future _onLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      var userId =
          await widget.viewModel.login.executeWithFuture(LoginRequestModel(
        username: username,
        password: password,
      ));
      if (userId == null) return;

      widget.viewModel.login.notifyListeners();
      if (context.mounted) {
        context.go(MySubscriptionsScreen.getPath());
      }
    } else {
      debugPrint("Formulário inválido");
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Insira um email valido";
    }

    if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,}$").hasMatch(value)) {
      return "Insira um email valido";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Insira uma senha valida";
    }

    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "A senha deve ter no mínimo 8 caracteres, incluindo letra maiúscula, minúscula, número e símbolo.";
    }

    return null;
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
                    Input(
                      hintText: "Email",
                      controller: _usernameController,
                      validator: validateEmail,
                    ),
                    PasswordInput(
                      hintText: "Senha",
                      controller: _passwordController,
                      validator: validatePassword,
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
                          onPressed: () => _onLogin(context),
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
                              ..onTap = () =>
                                  context.push(Routes.build(path: "/signup")),
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
