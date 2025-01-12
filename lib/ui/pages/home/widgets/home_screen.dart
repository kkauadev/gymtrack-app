import 'package:flutter/material.dart';
import 'package:gymtrack/ui/pages/home/view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //return Container(
    //  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //  child: Column(
    //    children: [
    //      TrainingCompleteBox(
    //        completed: false,
    //        onTap: () => print("asdasd"),
    //      )
    //    ],
    //  ),
    //);
    return Center(
      child: Text(
        "Nada aqui por enquanto, passe para a aba de treinos",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
