import 'package:gymtrack/domain/models/default.dart';
import 'package:gymtrack/domain/models/exercise.dart';

enum DayType { rest, training }

class Day extends Default {
  final String name;
  final String trainingPlanId;
  final int position;
  final DayType type;
  final List<Exercise> exercises;

  Day({
    this.exercises = const [],
    required this.name,
    required this.position,
    required this.type,
    required this.trainingPlanId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  static Day fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'] as String,
      name: json['name'] as String,
      position: 0,
      type: DayType.rest,
      trainingPlanId: json['trainingPlanId'] as String,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      exercises: json['exercises'] != null
          ? (json['exercises'] as List<dynamic>)
              .map((e) => Exercise.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'trainingPlanId': trainingPlanId,
    };
  }

  Map<String, dynamic> toJsonWithExercises() {
    return {
      'name': name,
      'trainingPlanId': trainingPlanId,
      'exercises': exercises
          .map(
            (exercise) => {
              'name': exercise.name,
              'type': "WARMUP",
              'setsNumber': exercise.setsNumber,
              'repsNumber': exercise.repsNumber,
              'description': exercise.description,
              'observation': exercise.observation,
            },
          )
          .toList(),
    };
  }
}
