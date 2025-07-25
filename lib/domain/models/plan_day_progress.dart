import 'package:gymtrack/domain/models/default.dart';

class PlanDayProgress extends Default {
  PlanDayProgress({
    required this.planSubscriptionId,
    required this.dayId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String planSubscriptionId;
  final String dayId;

  static PlanDayProgress fromJson(Map<String, dynamic> json) {
    return PlanDayProgress(
      planSubscriptionId: json['planSubscriptionId'],
      dayId: json['dayId'],
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
