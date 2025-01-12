import 'package:gymtrack/domain/models/default.dart';

class TrainingPlan extends Default {
  TrainingPlan({
    required this.name,
    required this.userId,
    required this.timeInDays,
    required this.observation,
    required this.pathology,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String name;
  final String userId;
  final int timeInDays;
  final String observation;
  final String pathology;

  static TrainingPlan fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      timeInDays: json['timeInDays'] as int,
      observation: json['observation'] as String,
      pathology: json['pathology'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  @override
  String toString() {
    return "$id, $name, $userId";
  }
}
