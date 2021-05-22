import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../local/local_storage.dart';
import '../network/api/auth_api.dart';
import '../network/models/username_password.dart';

class AuthRepository {
  AuthApi authApi;
  LocalStorage localStorage;
  AuthRepository({required this.authApi, required this.localStorage});

  Future<Either<Failure, void>> login(String username, String password) async {
    try {
      final result = await authApi.login(UsernamePassword(username, password));
      if (result.error != null) {
        return Left(AuthFailure(result.error!));
      }
      if (result.accessToken != null)
        await localStorage.setAccessToken(result.accessToken!);
      return Right(null);
    } catch (e) {
      print(e);
      return Left(AuthFailure('Dio error'));
    }
  }

  signup(String username, String password) async =>
      await authApi.signup(UsernamePassword(username, password));

  Future<Either<Failure, void>> autoLogin() async {
    if (localStorage.accessToken == null) {
      return Left(AuthFailure('Please login to continue!'));
    }
    final result =
        await authApi.checkToken({'access_token': localStorage.accessToken});
    if (result.error != null) {
      return Left(AuthFailure(result.error!));
    }
    return Right(null);
  }

  logout() async => await localStorage.removeAccessToken();
}
