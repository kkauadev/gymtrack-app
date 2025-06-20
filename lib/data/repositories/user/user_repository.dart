import 'package:gymtrack/domain/models/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class UserRepository {
  Future<Result<User>> getUser(String userId);
  Future<Result<User>> updateUser(User user);
}
