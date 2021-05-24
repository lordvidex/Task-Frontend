import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ACCESS_TOKEN = 'access_token';

abstract class LocalStorage {
  LocalStorage() {
    attachAccessTokenToHeader();
  }
  String? get accessToken;
  void attachAccessTokenToHeader();
  Future<void> setAccessToken(String token);
  Future<void> removeAccessToken();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences prefs;
  final Dio dio;
  LocalStorageImpl(this.prefs, this.dio);
  @override
  String? get accessToken => prefs.getString(ACCESS_TOKEN);

  @override
  Future<void> setAccessToken(String token) async {
    print('YOOOOOOO');
    await prefs.setString(ACCESS_TOKEN, token);
    attachAccessTokenToHeader();
  }

  @override
  Future<void> removeAccessToken() async {
    await prefs.remove(ACCESS_TOKEN);
  }

  @override
  void attachAccessTokenToHeader() {
    if (prefs.containsKey(ACCESS_TOKEN)) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $accessToken';
    }
  }
}
