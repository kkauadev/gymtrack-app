import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/ui/pages/training_plan/list/components/training_plan_card.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_view_model.dart';

class MyTrainingPlansScreen extends StatelessWidget {
  const MyTrainingPlansScreen({super.key, required this.viewModel});

  final MyTrainingPlansViewModel viewModel;

  static const _pathTemplate = '/training-plan/:userId/my-list';

  static String name = '/my-list';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Planos de Treino"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: CommandBuilder(
                  command: viewModel.load,
                  onData: (context, data, param) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: data.length,
                      itemBuilder: (context, index) => TrainingPlanCard(
                        trainingPlan: data[index],
                        userId: viewModel.userId,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
