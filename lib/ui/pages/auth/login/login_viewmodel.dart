import 'package:command_it/command_it.dart';
import 'package:gymtrack/data/repositories/auth/auth_repository.dart';
import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';

class LoginViewModel {
  final AuthRepository _authRepository;
  final AuthNotifierService _authNotifierService;

  LoginViewModel(
      AuthRepository authRepository, AuthNotifierService authNotifierService)
      : _authRepository = authRepository,
        _authNotifierService = authNotifierService {
    login = Command.createAsync(
      _login,
      initialValue: null,
    );
  }

  late Command<LoginRequestModel, String?> login;

  Future<String?> _login(LoginRequestModel data) async {
    final res = await _authRepository.login(data);

    if (res.isSuccess()) {
      return _authNotifierService.getUserId();
    } else {
      throw res.exceptionOrNull()!;
    }
  }
}
