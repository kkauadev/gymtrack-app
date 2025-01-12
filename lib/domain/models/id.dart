class Id {
  const Id({required this.value});
  final String value;

  static Id fromJson(Map<String, dynamic> json) {
    return Id(
      value: json['value'],
    );
  }
}
