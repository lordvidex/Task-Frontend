import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/failure.dart';
import '../../domain/usecases/autologin_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase? loginUseCase;
  final LogoutUseCase? logoutUseCase;
  final AutoLoginUseCase? autoLoginUseCase;
  final SignupUseCase? signupUseCase;
  AuthBloc(
      {this.loginUseCase,
      this.logoutUseCase,
      this.autoLoginUseCase,
      this.signupUseCase})
      : super(AuthInitial()) {
    add(AutoLoginEvent());
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthenticatingState();
    if (event is LoginEvent) {
      final result = await loginUseCase!(event.username, event.password);
      yield result.fold((failure) => _handleFailureCases(failure),
          (success) => AuthenticatedState());
    } else if (event is AutoLoginEvent) {
      final result = await autoLoginUseCase!();
      yield result.fold((failure) => _handleFailureCases(failure),
          (success) => AuthenticatedState());
    } else if (event is SignupEvent) {
      final result = await signupUseCase!(event.username, event.password);
      result.fold(
          (left) => _handleFailureCases(left), (right) => AuthenticatedState());
    }
  }

  AuthState? _handleFailureCases(Failure failure) {
    if (failure is AuthFailure) {
      return UnauthenticatedState(message: failure.toString());
    }
    return null;
  }
}
