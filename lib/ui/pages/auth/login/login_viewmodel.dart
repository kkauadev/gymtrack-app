import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/auth/auth_repository.dart';
import 'package:gymtrack/data/services/api/model/login_request_model.dart';

class LoginViewModel {
  final AuthRepository _authRepository;

  LoginViewModel(AuthRepository authRepository)
      : _authRepository = authRepository {
    login = Command.createAsync(
      _login,
      initialValue: null,
    );
  }

  late Command<LoginRequestModel, String?> login;

  Future<String?> _login(LoginRequestModel data) async {
    final res = await _authRepository.login(data);

    if (res.isSuccess()) {
      return res.getOrNull();
    } else {
      throw res.exceptionOrNull()!;
    }
  }
}
