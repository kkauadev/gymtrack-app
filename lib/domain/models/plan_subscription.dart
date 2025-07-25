import 'package:gymtrack/domain/models/default.dart';
import 'package:gymtrack/domain/models/plan_day_progress.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

enum PlanSubscriptionStatus { notStarted, inProgress, canceled, completed }

class PlanSubscription extends Default {
  PlanSubscription({
    required this.trainingPlan,
    required this.userId,
    required this.status,
    required this.planDayProgress,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String? userId;
  final PlanSubscriptionStatus status;
  final TrainingPlan trainingPlan;
  final List<PlanDayProgress?> planDayProgress;

  static PlanSubscriptionStatus statusFromJson(String? value) {
    switch (value) {
      case "NOT_STARTED":
        return PlanSubscriptionStatus.notStarted;
      case "IN_PROGRESS":
        return PlanSubscriptionStatus.inProgress;
      case "CANCELED":
        return PlanSubscriptionStatus.canceled;
      case "COMPLETED":
        return PlanSubscriptionStatus.completed;
      default:
        return PlanSubscriptionStatus.notStarted;
    }
  }

  static PlanSubscription fromJson(Map<String, dynamic> json) {
    return PlanSubscription(
      planDayProgress: (json['planDayProgress'] as List<dynamic>?)
              ?.map((obj) => obj == null ? null : PlanDayProgress.fromJson(obj))
              .toList() ??
          [],
      trainingPlan: TrainingPlan.fromJson(json['trainingPlan']),
      userId: json['userId'],
      status: statusFromJson(json['status']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']!) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']!) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']!) : null,
      id: json['id'],
    );
  }
}
