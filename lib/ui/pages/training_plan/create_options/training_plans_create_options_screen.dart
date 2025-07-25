import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/ui/pages/training_plan/create/training_plans_create_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/list/training_plans_list_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_screen.dart';

class TrainingPlansCreateOptionsScreen extends StatelessWidget {
  static const _pathTemplate = '/training-plan/:userId';

  static String name = '/training-plan/:userId';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  final String userId;

  const TrainingPlansCreateOptionsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () =>
              context.push(MySubscriptionsScreen.getPath({'userId': userId})),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 64, 32, 128),
          child: Column(
            spacing: 32,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(
                      TrainingPlansCreateScreen.getPath({'userId': userId})),
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
                  onTap: () => context.push(
                      TrainingPlansListScreen.getPath({'userId': userId})),
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
                  onTap: () => context
                      .push(MyTrainingPlansScreen.getPath({'userId': userId})),
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
