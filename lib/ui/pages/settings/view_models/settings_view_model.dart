import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/user/user_repository.dart';
import 'package:gymtrack/domain/models/user.dart';

class SettingsViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  SettingsViewModel({required UserRepository userRepository})
      : _userRepository = userRepository {
    loadUser = Command.createAsync(_loadUser, initialValue: null);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => loadUser.execute("c5fbbbdc-2c41-47b5-88fe-1d3215e37abd"));
  }

  late Command<String, User?> loadUser;

  Future<User?> _loadUser(String userId) async {
    final res = await _userRepository.getUser(userId);

    return res.getOrNull();
  }
}
