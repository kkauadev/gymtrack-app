import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _tokenKey = 'TOKEN';

  AsyncResult<String> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      if (sharedPreferences.getString(_tokenKey) == null) {
        throw Error();
      }

      return Success(sharedPreferences.getString(_tokenKey)!);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
