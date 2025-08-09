import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training_plan/list/training_plans_list_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/list/components/training_plan_card.dart';

class TrainingPlansListScreen extends StatefulWidget {
  static const _pathTemplate = '/training-plan/list';

  static String name = '/list';

  static String getPath() {
    var path = _pathTemplate;
    return path;
  }

  const TrainingPlansListScreen({super.key, required this.viewModel});

  final TrainingPlansListViewModel viewModel;

  @override
  State<StatefulWidget> createState() => TrainingPlansListScreenState();
}

class TrainingPlansListScreenState extends State<TrainingPlansListScreen> {
  Future<Object?> navigateDayList(String param) {
    return context.push(
      Routes.build(path: "/day", method: "/$param", param: "/list"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: CommandBuilder(
                  command: widget.viewModel.load,
                  onData: (context, data, param) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: data.length,
                      itemBuilder: (context, index) => TrainingPlanCard(
                        trainingPlan: data[index],
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
