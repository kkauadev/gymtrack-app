import 'package:gymtrack/domain/models/default.dart';

class Day extends Default {
  final String trainingPlanId;

  Day({
    required this.trainingPlanId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  static Day fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'] as String,
      trainingPlanId: json['trainingPlanId'] as String,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': "Exemplo",
      'trainingPlanId': trainingPlanId,
    };
  }
}
