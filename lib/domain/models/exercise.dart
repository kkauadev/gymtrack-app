import 'package:gymtrack/domain/models/default.dart';

class Exercise extends Default {
  Exercise({
    required this.trainingId,
    required this.name,
    required this.setsNumber,
    required this.repsNumber,
    this.description,
    this.observation,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String trainingId;
  final String name;
  final int setsNumber;
  final int repsNumber;
  final String? description;
  final String? observation;

  static Exercise fromJson(Map<String, dynamic> json) {
    return Exercise(
      trainingId: json['trainingId'],
      id: json['id'],
      name: json['name'],
      repsNumber: json['repsNumber'],
      setsNumber: json['setsNumber'],
      description: json['description'],
      observation: json['observation'],
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
      'trainingId': trainingId,
      'type': 1,
      'setsNumber': setsNumber,
      'repsNumber': repsNumber,
      'description': description,
      'observation': observation,
    };
  }
}
