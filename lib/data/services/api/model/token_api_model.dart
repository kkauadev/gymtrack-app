class TokenApiModel {
  final String token;

  TokenApiModel({required this.token});

  static TokenApiModel fromJson(Map<String, dynamic> json) {
    return TokenApiModel(token: json['accessToken']);
  }
}
