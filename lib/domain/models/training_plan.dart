import 'package:gymtrack/domain/models/default.dart';

enum TrainingPlanType {
  exercise,
  cardio,
  another,
}

enum TrainingPlanLevel {
  basic,
  intermediary,
  advanced,
}

enum TrainingPlanVisibility {
  public,
  protected,
  private,
}

class TrainingPlan extends Default {
  TrainingPlan({
    required this.name,
    required this.authorId,
    required this.timeInDays,
    required this.observation,
    required this.pathology,
    required this.type,
    required this.level,
    required this.visibility,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String name;
  final String authorId;
  final int timeInDays;
  final String observation;
  final String pathology;
  final TrainingPlanType type;
  final TrainingPlanLevel level;
  final TrainingPlanVisibility visibility;

  static TrainingPlan fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      authorId: json['authorId'] as String,
      timeInDays: json['timeInDays'] as int,
      observation: json['observation'] as String,
      pathology: json['pathology'] as String,
      type: TrainingPlanType.values[json['type'] - 1],
      level: TrainingPlanLevel.values[json['level'] - 1],
      visibility: TrainingPlanVisibility.values[json['visibility'] - 1],
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
      'name': name,
      'authorId': authorId,
      'timeInDays': timeInDays,
      'observation': observation,
      'pathology': pathology,
      'type': type.index + 1,
      'level': level.index + 1,
      'visibility': 1,
    };
  }

  @override
  String toString() {
    return "$id, $name, $authorId";
  }
}
