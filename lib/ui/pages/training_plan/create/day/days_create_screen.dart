import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/components/button_add.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/components/exercise_list.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/days_create_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_screen.dart';

class DaysCreateScreen extends StatefulWidget {
  static const _pathTemplate = '/training-plan/:trainingPlanId/day/create';

  static String name = '/:trainingPlanId/day/create';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  const DaysCreateScreen({super.key, required this.viewModel});

  final DaysCreateViewModel viewModel;

  @override
  State<StatefulWidget> createState() => DaysCreateScreenState();
}

class DaysCreateScreenState extends State<DaysCreateScreen> {
  TextEditingController controller = TextEditingController();
  List<Day> days = [];
  List<String> weekDays = [
    "Domingo",
    "Segunda-feira",
    "Terca-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sabado",
  ];

  Future onAddDay(int index) async {
    if (days.any(
        (day) => day.name.toLowerCase() == controller.text.toLowerCase())) {
      return;
    }
    if (days.length >= 7) return;

    setState(() {
      days.add(Day(
        name: controller.text.isEmpty ? weekDays[index] : controller.text,
        position: days.length,
        type: DayType.rest,
        trainingPlanId: widget.viewModel.trainingPlanId,
        exercises: [],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Future onFinish() async {
      try {
        await widget.viewModel.createDays.executeWithFuture(days);
        if (context.mounted) {
          context.go(TrainingPlanMoreInfoScreen.getPath({
            'trainingPlanId': widget.viewModel.trainingPlanId,
          }));
        }
      } catch (e) {}
    }

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Button(
        label: "Finalizar",
        width: screenWidth / 2,
        onPressed: onFinish,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                SizedBox(height: screenHeight * 0.01),
            itemCount: days.length < 7 ? days.length + 1 : 7,
            itemBuilder: (context, index) {
              if (index == days.length && days.length < 7) {
                return ButtonAdd(
                  controller: controller,
                  onTap: () => onAddDay(index),
                );
              }

              return Column(
                spacing: screenWidth * 0.02,
                children: [
                  SizedBox(
                    height: screenHeight * 0.04,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(days[index].name),
                    ),
                  ),
                  ExerciseList(day: days[index]),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
