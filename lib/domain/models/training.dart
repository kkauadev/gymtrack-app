import 'package:gymtrack/domain/models/default.dart';

class Training extends Default {
  Training({
    required this.name,
    required this.dayId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  final String name;
  final String dayId;

  static Training fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      dayId: json['dayId'],
      name: json['name'] as String,
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
      'dayId': dayId,
    };
  }
}
