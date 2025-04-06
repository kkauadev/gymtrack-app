import 'package:gymtrack/data/services/api/model/login_request_model.dart';
import 'package:gymtrack/data/services/api/model/signup_request_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class AuthRepository {
  Future<Result> signup(SignupRequestModel data);
  Future<Result<String>> login(LoginRequestModel data);
}
