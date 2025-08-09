import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_screen.dart';

class TrainingPlanCard extends StatelessWidget {
  final TrainingPlan trainingPlan;

  const TrainingPlanCard({super.key, required this.trainingPlan});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => context.push(TrainingPlanMoreInfoScreen.getPath({
        'trainingPlanId': trainingPlan.id,
      })),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainingPlan.name,
                    style: textStyle?.copyWith(fontSize: 28),
                  ),
                  Row(spacing: 4, children: [
                    Icon(Icons.person, size: 20),
                    Text("Autor Fulano de tal")
                  ]),
                  Row(
                    spacing: 4,
                    children: [
                      TrainingPlanCardTag(
                        backgroundColor: Colors.deepPurpleAccent,
                        text: "Hypertrofia",
                      ),
                      TrainingPlanCardTag(
                        backgroundColor: Colors.brown,
                        text: "Hypertrofia",
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Tempo de treino em dias: ",
                    children: [
                      TextSpan(text: trainingPlan.timeInDays.toString())
                    ],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrainingPlanCardTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const TrainingPlanCardTag({
    super.key,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
