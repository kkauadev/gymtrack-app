import 'package:flutter/material.dart';
import 'package:command_it/command_it.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/user.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/input.dart';
import 'package:gymtrack/ui/pages/settings/settings_view_model.dart';

class SettingsProfileScreen extends StatefulWidget {
  const SettingsProfileScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<StatefulWidget> createState() => SettingsProfileScreenState();
}

class SettingsProfileScreenState extends State<SettingsProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future finish() async {
      await widget.viewModel.updateUser.executeWithFuture(User(
        email: _emailController.text,
        username: _usernameController.text,
      ));
      if (context.mounted) {
        context.push("/settings");
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              "Conta",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CommandBuilder(
            command: widget.viewModel.loadUser,
            onData: (context, data, param) {
              _usernameController.text = data!.username;
              _emailController.text = data.email;
              return Column(
                spacing: 20,
                children: [
                  Input(hintText: "username", controller: _usernameController),
                  Input(hintText: "email", controller: _emailController),
                  Button(label: "Enviar", onPressed: finish)
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
