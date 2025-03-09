import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/exercise.dart';

class DayApiModel extends Day {
  final List<ExerciseApiModel> exercises;

  DayApiModel({
    required super.name,
    required super.trainingPlanId,
    required this.exercises,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  static DayApiModel fromJson(Map<String, dynamic> json) {
    return DayApiModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      trainingPlanId: json['trainingPlanId'] as String,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      exercises: (json['exercises'] as List<dynamic>)
          .map((t) => ExerciseApiModel.fromJson(t as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ExerciseApiModel extends Exercise {
  ExerciseApiModel({
    required super.dayId,
    required super.name,
    required super.setsNumber,
    required super.repsNumber,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.id,
    super.description,
    super.observation,
  });

  static ExerciseApiModel fromJson(Map<String, dynamic> json) {
    return ExerciseApiModel(
        id: json['id'] as String?,
        dayId: json['dayId'] as String,
        name: json['name'] as String,
        setsNumber: json['setsNumber'] as int,
        repsNumber: json['repsNumber'] as int,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        description: json['description'] as String?,
        observation: json['observation'] as String?);
  }
}
