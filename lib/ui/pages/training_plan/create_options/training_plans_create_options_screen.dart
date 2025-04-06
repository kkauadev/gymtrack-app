import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrainingPlansCreateOptionsScreen extends StatelessWidget {
  const TrainingPlansCreateOptionsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 64, 32, 128),
          child: Column(
            spacing: 32,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push("/training-plan/$userId/create"),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      spacing: 32,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 64,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Text(
                          "Criar novo plano de treino",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Text(
                        "Buscar plano de treino online",
                        style: Theme.of(context).primaryTextTheme.titleLarge,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
