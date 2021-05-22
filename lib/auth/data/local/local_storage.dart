import 'package:shared_preferences/shared_preferences.dart';

const String ACCESS_TOKEN = 'access_token';

abstract class LocalStorage {
  String? get accessToken;
  Future<void> setAccessToken(String token);
  Future<void> removeAccessToken();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences prefs;
  LocalStorageImpl(this.prefs);
  @override
  String? get accessToken => prefs.getString(ACCESS_TOKEN);

  @override
  Future<void> setAccessToken(String token) async {
    await prefs.setString(ACCESS_TOKEN, token);
  }

  @override
  Future<void> removeAccessToken() async {
    await prefs.remove(ACCESS_TOKEN);
  }
}
