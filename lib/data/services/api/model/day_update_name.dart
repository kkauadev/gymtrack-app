class DayUpdateName {
  final String dayId;
  final String name;

  DayUpdateName({required this.dayId, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
