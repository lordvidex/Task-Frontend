part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);
}

class SignupEvent extends AuthEvent {
  final String username;
  final String password;
  SignupEvent(this.username, this.password);
}

class AutoLoginEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}