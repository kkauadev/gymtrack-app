import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training_plan/list/view_models/training_plans_list_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/list/widgets/button_add.dart';
import 'package:gymtrack/ui/pages/training_plan/list/widgets/button_help.dart';
import 'package:gymtrack/ui/pages/training_plan/list/widgets/training_plan_card.dart';
import 'package:gymtrack/ui/pages/training_plan/list/widgets/training_plan_delete_example.dart';

class TrainingPlansListScreen extends StatefulWidget {
  const TrainingPlansListScreen({super.key, required this.viewModel});

  final TrainingPlansListViewModel viewModel;

  @override
  State<StatefulWidget> createState() => TrainingPlansListScreenState();
}

class TrainingPlansListScreenState extends State<TrainingPlansListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonHelp(
                  onTap: () => trainingPlanExampleBuilder(context),
                ),
                ButtonAdd(
                  onTap: () => context.push("/training-plan/1/create-options"),
                )
              ],
            ),
          ),
          CommandBuilder(
            command: widget.viewModel.load,
            whileExecuting: (context, lastValue, param) =>
                Center(child: CircularProgressIndicator()),
            onData: (context, data, param) => Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: data.length,
                itemBuilder: (context, i) => TrainingPlanCard(
                  trainingPlan: data[i],
                  onTap: () => context.push(
                    Routes.build(
                      path: "/training",
                      method: "/list",
                      param: "/${data[i].id}",
                    ),
                  ),
                  onTapDelete: () {
                    widget.viewModel.deleteOne.execute(data[i].id);
                    widget.viewModel.load.execute(widget.viewModel.userId);
                  },
                ),
              ),
            ),
            onError: (context, p1, lastValue, p3) => Center(
              child: Text('Erro ao carregar planos de treino.'),
            ),
          )
        ],
      ),
    );
  }
}
