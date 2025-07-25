class User {
  final String username;
  final String email;
  final String? id;

  User({required this.username, required this.email, this.id});

  static User fromJson(Map<String, dynamic> json) {
    return User(
        username: json['firstName'], email: json['email'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': username,
      'email': email,
    };
  }
}
