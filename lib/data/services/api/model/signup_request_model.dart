class SignupRequestModel {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  factory SignupRequestModel({
    required String email,
    required String password,
    required String name,
  }) {
    final splitedName = name.split(" ");

    String firstName = splitedName.first;
    String lastName =
        splitedName.length > 1 ? splitedName.sublist(1).join(" ") : "";

    return SignupRequestModel._(
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
    };
  }

  const SignupRequestModel._({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
