import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/plan_subscription.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_screen.dart';

class PlanSubscribeCard extends StatelessWidget {
  final PlanSubscription data;
  final Future Function() onTapInitDay;
  const PlanSubscribeCard(
      {super.key, required this.data, required this.onTapInitDay});

  Widget _statusCard(PlanSubscription subscription) {
    switch (subscription.status) {
      case PlanSubscriptionStatus.notStarted:
        return PlanSubscribeStatus(
          text: "Nao iniciado",
          backgroundColor: Colors.grey,
        );
      case PlanSubscriptionStatus.inProgress:
        return PlanSubscribeStatus(
          text: "Atual",
          backgroundColor: Colors.lightGreen,
        );
      case PlanSubscriptionStatus.completed:
        return PlanSubscribeStatus(
          text: "Finalizado",
          backgroundColor: Colors.lightBlue,
        );
      case PlanSubscriptionStatus.canceled:
        return PlanSubscribeStatus(
          text: "Cancelado",
          backgroundColor: Colors.redAccent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).primaryTextTheme;

    Future onTap() async {
      await context.push(TrainingPlanMoreInfoScreen.getPath({
        'trainingPlanId': data.trainingPlan.id,
      }));
    }

    bool isSameDay(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    final hasProgressToday = data.planDayProgress.any((element) {
      if (element == null || element.createdAt == null) return false;
      return isSameDay(element.createdAt!, DateTime.now());
    });

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
        child: Column(
          spacing: 20,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.trainingPlan.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          _statusCard(data),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (data.status == PlanSubscriptionStatus.inProgress) ...[
              Column(
                spacing: 12,
                children: [
                  Row(
                    children: List.generate(7, (index) {
                      bool isCompleted =
                          data.planDayProgress[index] != null ? true : false;

                      return Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isCompleted ? Colors.green : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.check, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  !hasProgressToday
                      ? Button(label: "Iniciar treino", onPressed: onTapInitDay)
                      : SizedBox()
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

class PlanSubscribeStatus extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const PlanSubscribeStatus({
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
