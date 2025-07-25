import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/default.dart';

enum TrainingPlanType {
  exercise,
  cardio,
  another,
}

extension TrainingPlanTypeExtension on TrainingPlanType {
  String toShortString() {
    return toString().split('.').last;
  }

  String get friendlyName {
    switch (this) {
      case TrainingPlanType.exercise:
        return 'Exercício';
      case TrainingPlanType.cardio:
        return 'Cardio';
      case TrainingPlanType.another:
        return 'Outro';
    }
  }
}

enum TrainingPlanLevel {
  basic,
  intermediary,
  advanced,
}

extension TrainingPlanLevelExtension on TrainingPlanLevel {
  String get friendlyName {
    switch (this) {
      case TrainingPlanLevel.basic:
        return 'Básico';
      case TrainingPlanLevel.intermediary:
        return 'Intermediário';
      case TrainingPlanLevel.advanced:
        return 'Avançado';
    }
  }
}

enum TrainingPlanVisibility {
  public,
  protected,
  private,
}

extension TrainingPlanVisibilityExtension on TrainingPlanVisibility {
  String get friendlyName {
    switch (this) {
      case TrainingPlanVisibility.public:
        return 'Público';
      case TrainingPlanVisibility.protected:
        return 'Protegido';
      case TrainingPlanVisibility.private:
        return 'Privado';
    }
  }
}

class TrainingPlan extends Default {
  TrainingPlan({
    this.days = const [],
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
  final String? observation;
  final String? pathology;
  final TrainingPlanType type;
  final TrainingPlanLevel level;
  final TrainingPlanVisibility visibility;
  final List<Day> days;

  static TrainingPlanType typeFromJson(String? value) {
    return switch (value) {
      "HYPERTROPHY" => TrainingPlanType.exercise,
      "STRENGTH" => TrainingPlanType.cardio,
      "MIXED" => TrainingPlanType.another,
      _ => TrainingPlanType.exercise
    };
  }

  static TrainingPlanLevel levelFromJson(String? value) {
    return switch (value) {
      "BEGINNER" => TrainingPlanLevel.basic,
      "INTERMEDIARY" => TrainingPlanLevel.intermediary,
      "ADVANCED" => TrainingPlanLevel.advanced,
      _ => TrainingPlanLevel.basic
    };
  }

  static TrainingPlanVisibility visibilityFromJson(String? value) {
    return switch (value) {
      "PUBLIC" => TrainingPlanVisibility.public,
      "PROTECTED" => TrainingPlanVisibility.private,
      "PRIVATE" => TrainingPlanVisibility.protected,
      _ => TrainingPlanVisibility.public
    };
  }

  static TrainingPlan fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      id: json['id'] as String,
      name: json['name'] as String,
      authorId: json['authorId'] as String,
      timeInDays: json['timeInDays'] as int,
      observation: json['observation'],
      pathology: json['pathology'],
      type: typeFromJson(json['type']),
      level: levelFromJson(json['level']),
      visibility: visibilityFromJson(json['visibility']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      days: json['days'] != null
          ? (json['days'] as List<dynamic>).map((e) => Day.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'authorId': authorId,
      'timeInDays': timeInDays,
      'type': "STRENGTH",
      'level': "INTERMEDIARY",
      'visibility': "PUBLIC",
    };
  }

  @override
  String toString() {
    return "$id, $name, $authorId";
  }
}
