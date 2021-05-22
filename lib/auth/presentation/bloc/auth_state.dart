part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class UnauthenticatedState extends AuthState {
  final String? message;
  UnauthenticatedState({this.message});
}
class AuthenticatingState extends AuthState {}
class AuthenticatedState extends AuthState {}
