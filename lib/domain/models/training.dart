import 'package:gymtrack/domain/models/default.dart';

class Training extends Default {
  Training({
    required this.name,
    required this.trainingPlanId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String name;
  final String trainingPlanId;

  static Training fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      trainingPlanId: json['trainingPlanId'],
      name: json['name'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}
