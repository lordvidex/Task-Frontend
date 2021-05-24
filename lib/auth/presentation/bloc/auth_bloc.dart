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
  final LoginUsecase? loginUsecase;
  final LogoutUsecase? logoutUsecase;
  final AutoLoginUsecase? autoLoginUsecase;
  final SignupUsecase? signupUsecase;
  AuthBloc(
      {this.loginUsecase,
      this.logoutUsecase,
      this.autoLoginUsecase,
      this.signupUsecase})
      : super(AuthInitial()) {
    add(AutoLoginEvent());
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthenticatingState();
    if (event is LoginEvent) {
      final result = await loginUsecase!(event.username, event.password);
      yield result.fold((failure) => _handleFailureCases(failure),
          (success) => AuthenticatedState());
    } else if (event is AutoLoginEvent) {
      final result = await autoLoginUsecase!();
      yield result.fold((failure) => _handleFailureCases(failure),
          (success) => AuthenticatedState());
    } else if (event is SignupEvent) {
      final result = await signupUsecase!(event.username, event.password);
      result.fold(
          (left) => _handleFailureCases(left), (right) => AuthenticatedState());
    } else if (event is LogoutEvent) {
      await logoutUsecase!();
      yield UnauthenticatedState();
    }
  }

  AuthState? _handleFailureCases(Failure failure) {
    if (failure is AuthFailure) {
      return UnauthenticatedState(message: failure.toString());
    }
    return null;
  }
}
