import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/ui/pages/training_plan/create/training_plans_create_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/list/training_plans_list_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_screen.dart';

class TrainingPlansCreateOptionsScreen extends StatelessWidget {
  static const _pathTemplate = '/training-plan';

  static String name = '/training-plan';

  static String getPath() {
    var path = _pathTemplate;
    return path;
  }

  const TrainingPlansCreateOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          if (context.canPop()) return context.pop();

          return context.go(MySubscriptionsScreen.getPath());
        }),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 64, 32, 128),
          child: Column(
            spacing: 32,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      context.push(TrainingPlansCreateScreen.getPath()),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      spacing: 12,
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
                child: GestureDetector(
                  onTap: () => context.push(TrainingPlansListScreen.getPath()),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      spacing: 12,
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
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(MyTrainingPlansScreen.getPath()),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.perm_identity,
                          size: 64,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Text(
                          "Ver os planos criados por mim",
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        )
                      ],
                    ),
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
