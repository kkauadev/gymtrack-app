import 'package:command_it/command_it.dart';
import 'package:flutter/widgets.dart';
import 'package:gymtrack/data/repositories/user/user_repository.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/domain/models/user.dart';

class SettingsViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthNotifierService _authNotifierService;

  SettingsViewModel(
      {required UserRepository userRepository,
      required AuthNotifierService authNotifierService})
      : _userRepository = userRepository,
        _authNotifierService = authNotifierService {
    loadUser = Command.createAsync(_loadUser, initialValue: null);
    updateUser = Command.createAsync(_updateUser, initialValue: null);
    logout = Command.createAsyncNoParam(_logout, initialValue: null);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => loadUser.execute("c5fbbbdc-2c41-47b5-88fe-1d3215e37abd"));
  }

  late Command<String, User?> loadUser;
  late Command<User, User?> updateUser;
  late Command<void, String?> logout;

  Future<User?> _loadUser(String userId) async {
    final res = await _userRepository.getUser(userId);

    return res.getOrNull();
  }

  Future<User?> _updateUser(User user) async {
    final res = await _userRepository.updateUser(User(
      email: user.email,
      username: user.username,
      id: "c5fbbbdc-2c41-47b5-88fe-1d3215e37abd",
    ));

    return res.getOrNull();
  }

  Future<String?> _logout() async {
    _authNotifierService.logout();
    return "Success";
  }
}
