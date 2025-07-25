import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_screen.dart';

class TrainingPlanMoreInfoScreen extends StatefulWidget {
  static const _pathTemplate =
      '/training-plan/:userId/more_info/:trainingPlanId';

  static String name = '/more_info/:trainingPlanId';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  final TrainingPlanMoreInfoViewModel viewModel;

  const TrainingPlanMoreInfoScreen({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => TrainingPlanMoreInfoScreenState();
}

class TrainingPlanMoreInfoScreenState
    extends State<TrainingPlanMoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    Future onTapSubscribe() async {
      await widget.viewModel.createSubscription.executeWithFuture();

      if (context.mounted) {
        await context.push(
          MySubscriptionsScreen.getPath({"userId": widget.viewModel.userId}),
        );
      }
    }

    final textStyle = Theme.of(context).textTheme.displayLarge;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert_outlined),
            borderRadius: BorderRadius.circular(20),
            menuPadding:
                EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 8),
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: "asdadas",
                  child: Text(
                    "Editar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                PopupMenuItem<String>(
                  value: "asdadas",
                  child: Text(
                    "Desistir",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CommandBuilder(
          command: widget.viewModel.get,
          onData: (context, data, param) {
            if (data == null) return Text("llll");
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(data.name, style: textStyle),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 4),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Visibilidade: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                text: data.visibility.friendlyName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              )
                            ])),
                        RichText(
                            text: TextSpan(
                                text: "Foco: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                text: data.type.friendlyName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              )
                            ])),
                        RichText(
                          text: TextSpan(
                            text: "Nivel: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: data.level.friendlyName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.days.length,
                            itemBuilder: (context, i) => Container(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  DayCard(day: data.days[i]),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.days[i].exercises.length,
                                    itemBuilder: (context, j) => ExerciseCard(
                                      exercise: data.days[i].exercises[j],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        CommandBuilder(
                          command: widget.viewModel.existsPlanSubscription,
                          onData: (context, data, param) {
                            if (!data) return SizedBox();

                            return Button(
                              label: "Inscrever",
                              onPressed: onTapSubscribe,
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final Day day;
  const DayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium;

    return Text(day.name, style: textStyle?.copyWith(fontSize: 34));
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: textStyle?.copyWith(fontSize: 20),
                ),
                if (exercise.observation != null) ...[
                  Text(
                    exercise.observation!,
                    style: textStyle?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: exercise.setsNumber.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: "x"),
                TextSpan(text: exercise.repsNumber.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
