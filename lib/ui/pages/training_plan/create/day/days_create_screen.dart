import 'package:flutter/material.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/days_create_view_model.dart';

class DaysCreateScreen extends StatefulWidget {
  const DaysCreateScreen({super.key, required this.viewModel});

  final DaysCreateViewModel viewModel;

  @override
  State<StatefulWidget> createState() => DaysCreateScreenState();
}

class DaysCreateScreenState extends State<DaysCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
