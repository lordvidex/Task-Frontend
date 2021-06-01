import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/data/local/local_storage.dart';
import 'auth/data/network/api/auth_api.dart';
import 'auth/data/repositories/auth_repository.dart';
import 'auth/domain/repositories/auth_repository.dart';
import 'auth/domain/usecases/autologin_usecase.dart';
import 'auth/domain/usecases/login_usecase.dart';
import 'auth/domain/usecases/logout_usecase.dart';
import 'auth/domain/usecases/signup_usecase.dart';
import 'auth/presentation/bloc/auth_bloc.dart';
import 'tasks/data/network/api/task_api.dart';
import 'tasks/data/repositories/task_repository_impl.dart';
import 'tasks/domain/repositories/task_repository.dart';
import 'tasks/domain/usecases/create_task_usecase.dart';
import 'tasks/domain/usecases/delete_task_usecase.dart';
import 'tasks/domain/usecases/edit_task_status_usecase.dart';
import 'tasks/domain/usecases/fetch_usecase.dart';
import 'tasks/presentation/bloc/task_bloc.dart';

GetIt I = GetIt.instance;

class DI {
  final Dio taskDio = Dio(BaseOptions(
      baseUrl: "http://taskserver.eu-central-1.elasticbeanstalk.com",
      connectTimeout: 10000,
      sendTimeout: 10000,
      receiveTimeout: 10000,
      headers: {"Access-Control-Allow-Origin": "*"}))
    ..interceptors
        .add(PrettyDioLogger(requestHeader: true, error: true, request: true));
  Future<void> init() async {
    //! blocs
    I.registerFactory<AuthBloc>(() => AuthBloc(
          loginUsecase: I(),
          autoLoginUsecase: I(),
          logoutUsecase: I(),
          signupUsecase: I(),
        ));
    I.registerFactory(() => TaskBloc(
          editTaskStatusUsecase: I(),
          fetchTaskUsecase: I(),
          createTaskUsecase: I(),
          deleteUsecase: I(),
        ));

    //! usecases
    // auth usecases
    I.registerLazySingleton(() => LoginUsecase(I()));
    I.registerLazySingleton(() => LogoutUsecase(I()));
    I.registerLazySingleton(() => AutoLoginUsecase(I()));
    I.registerLazySingleton(() => SignupUsecase(I()));

    // task usecases
    I.registerLazySingleton(() => FetchTasksUsecase(I()));
    I.registerLazySingleton(() => EditTaskStatusUsecase(I()));
    I.registerLazySingleton(() => CreateTaskUsecase(I()));
    I.registerLazySingleton(() => DeleteUsecase(I()));

    //! repositories
    I.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(authApi: I(), localStorage: I()));
    I.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(taskApi: I()));
    //! data sources
    I.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(I(), I()));

    //! Apis
    I.registerLazySingleton(() => AuthApi(
          I(),
        ));
    I.registerLazySingleton(() => TaskApi(
          I(),
        ));
    //! register dios
    I.registerLazySingleton<Dio>(() => taskDio);

    //! externals
    final sharedPrefs = await SharedPreferences.getInstance();
    I.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  }
}
