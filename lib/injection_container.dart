import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/data/local/local_storage.dart';
import 'auth/data/network/api/auth_api.dart';
import 'auth/data/repositories/auth_repository.dart';
import 'auth/domain/usecases/autologin_usecase.dart';
import 'auth/domain/usecases/login_usecase.dart';
import 'auth/domain/usecases/logout_usecase.dart';
import 'auth/domain/usecases/signup_usecase.dart';
import 'auth/presentation/bloc/auth_bloc.dart';

GetIt I = GetIt.instance;

class DI {
  final Dio taskDio = Dio(BaseOptions(
      baseUrl: "http://localhost:3000",
      connectTimeout: 10000,
      receiveTimeout: 10000));
  Future<void> init() async {
    //! blocs
    I.registerFactory<AuthBloc>(() => AuthBloc(
          loginUseCase: I(),
          autoLoginUseCase: I(),
          logoutUseCase: I(),
          signupUseCase: I(),
        ));

    //! usecases
    I.registerLazySingleton(() => LoginUseCase(I()));
    I.registerLazySingleton(() => LogoutUseCase(I()));
    I.registerLazySingleton(() => AutoLoginUseCase(I()));
    I.registerLazySingleton(() => SignupUseCase(I()));

    //! repositories
    I.registerLazySingleton(
        () => AuthRepository(authApi: I(), localStorage: I()));

    //! data sources
    I.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(I()));
    
    //! Apis
    // I.registerLazySingleton<TaskApi>(() => TaskApi(dio: taskDio));
    I.registerLazySingleton(() => AuthApi(I(),baseUrl: "http://localhost:3000"));

    //! register dios
    I.registerLazySingleton<Dio>(() => taskDio);

    //! externals
    final sharedPrefs = await SharedPreferences.getInstance();
    I.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    attachAccessToken();
  }

  void attachAccessToken() {
    SharedPreferences sharedPrefs = I.get<SharedPreferences>();
    if (!sharedPrefs.containsKey('access_token')) {
      return;
    }
    I.get<Dio>().options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${sharedPrefs.get('access_token')}';
  }
}
