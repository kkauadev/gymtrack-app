import 'package:gymtrack/data/repositories/user/user_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/user.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryRemote implements UserRepository {
  final ApiClient _apiClient;

  UserRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Result<User>> getUser(String userId) {
    return _apiClient.getUser(userId);
  }

  @override
  Future<Result<User>> updateUser(User user) async {
    await Future.delayed(Duration(milliseconds: 400));
    return Success(User(username: "username", email: "email"));
  }
}
