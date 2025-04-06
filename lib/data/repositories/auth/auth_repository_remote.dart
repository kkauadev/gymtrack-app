import 'package:gymtrack/data/repositories/auth/auth_repository.dart';
import 'package:gymtrack/data/services/api/auth_api_client.dart';
import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/data/services/api/model/signup_request_model.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthApiClient _apiClient;
  final AuthNotifierService _authNotifierService;

  AuthRepositoryRemote(
      {required AuthApiClient apiClient,
      required AuthNotifierService authNotifierService})
      : _apiClient = apiClient,
        _authNotifierService = authNotifierService;

  @override
  Future<Result> signup(SignupRequestModel data) {
    return _apiClient.signup(data);
  }

  @override
  Future<Result<String>> login(LoginRequestModel data) async {
    final res = await _apiClient.login(data);
    if (res.isSuccess()) {
      _authNotifierService.saveToken(res.getOrNull()!);
    }
    return res;
  }
}
