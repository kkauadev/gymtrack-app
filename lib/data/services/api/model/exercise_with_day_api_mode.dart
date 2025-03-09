class ExerciseWithDayApiMode {
  final String trainingName;
  final String dayId;
  final String name;
  final int setsNumber;
  final int repsNumber;
  final String? description;
  final String? observation;

  ExerciseWithDayApiMode({
    required this.trainingName,
    required this.dayId,
    required this.name,
    required this.setsNumber,
    required this.repsNumber,
    this.description,
    this.observation,
  });

  static ExerciseWithDayApiMode fromJson(Map<String, dynamic> json) {
    return ExerciseWithDayApiMode(
      trainingName: json['trainingName'] as String,
      dayId: json['dayId'] as String,
      name: json['name'] as String,
      setsNumber: json['setsNumber'] as int,
      repsNumber: json['repsNumber'] as int,
      description: json['description'] as String?,
      observation: json['observation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trainingName': trainingName,
      'dayId': dayId,
      'name': name,
      'type': 1,
      'setsNumber': setsNumber,
      'repsNumber': repsNumber,
      'description': description,
      'observation': observation,
    };
  }
}
