import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/services/api/model/signup_request_model.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/auth/signup/signup_viewmodel.dart';

import '../../../core/widgets/button.dart';
import '../../../core/widgets/input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.viewModel});

  final SignupViewmodel viewModel;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscuredPassword = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _onSignup() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String name = _nameController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        throw Exception();
      }

      debugPrint(
          "Email: $email, Nome: $name, Senha: $password, Confirmar Senha: $confirmPassword");

      widget.viewModel.signup(SignupRequestModel(
        email: email,
        password: password,
        name: name,
      ));
    } else {
      debugPrint("Formulário inválido");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                    controller: _emailController,
                  ),
                  Input(
                    hintText: "Nome",
                    controller: _nameController,
                  ),
                  PasswordInput(
                    hintText: "Senha",
                    controller: _passwordController,
                    showPassword: _isObscuredPassword,
                    onPressShowPassword: () => setState(
                      () => _isObscuredPassword = !_isObscuredPassword,
                    ),
                  ),
                  PasswordInput(
                    hintText: "Confirmar senha",
                    controller: _confirmPasswordController,
                    showPassword: _isObscuredPassword,
                    onPressShowPassword: () => setState(
                      () => _isObscuredPassword = !_isObscuredPassword,
                    ),
                  ),
                  Button(
                    onPressed: _onSignup,
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
          ),
        ),
      ),
    );
  }
}
