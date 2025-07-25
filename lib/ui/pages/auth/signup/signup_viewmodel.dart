import 'package:command_it/command_it.dart';
import 'package:flutter/widgets.dart';
import 'package:gymtrack/data/repositories/auth/auth_repository.dart';
import 'package:gymtrack/data/services/api/model/signup_request_model.dart';

class SignupViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignupViewmodel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    signup = Command.createAsync(_signup, initialValue: null);
  }

  late Command<SignupRequestModel, String?> signup;

  Future<String?> _signup(SignupRequestModel data) async {
    final result = await _authRepository.signup(data);

    if (result.isSuccess()) {
      return "Sucesso";
    } else {
      throw Exception();
    }
  }
}
