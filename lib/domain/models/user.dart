class User {
  final String username;

  User({required this.username});

  static User fromJson(Map<String, dynamic> json) {
    return User(username: json['firstName']);
  }
}
