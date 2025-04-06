import 'package:flutter/material.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/pages/home/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
          label: "label",
          onPressed: () {
            final a = AuthNotifierService();
            a.logout();
          }),
    );
  }
}
