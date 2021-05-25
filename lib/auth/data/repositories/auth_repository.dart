import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../local/local_storage.dart';
import '../network/api/auth_api.dart';
import '../../../core/exceptions.dart';
import '../network/models/username_password.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthApi authApi;
  LocalStorage localStorage;
  AuthRepositoryImpl({required this.authApi, required this.localStorage});

  @override
  Future<Either<Failure, void>> login(String username, String password) async {
    try {
      final result = await authApi.login(UsernamePassword(username, password));
      if (result.accessToken != null) {
        await localStorage.setAccessToken(result.accessToken!);
      }
      return Right(null);
    } on DioError catch (e) {
      return Left(AuthFailure(e.errorMessage()));
    }
  }

  @override
  Future<Either<Failure, void>> signup(String username, String password) async {
    try {
      final result = await authApi.signup(UsernamePassword(username, password));
      if (result.accessToken != null) {
        await localStorage.setAccessToken(result.accessToken!);
      }
      return Right(null);
    } on DioError catch (e) {
      return Left(AuthFailure(e.errorMessage()));
    }
  }

  @override
  Future<Either<Failure, void>> autoLogin() async {
    if (localStorage.accessToken == null) {
      return Left(AuthFailure('Please login to continue!'));
    }
    final result =
        await authApi.checkToken({'access_token': localStorage.accessToken});
    if (result.error != null) {
      return Left(AuthFailure(result.error!));
    }
    localStorage.attachAccessTokenToHeader();
    return Right(null);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await localStorage.removeAccessToken());
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
