part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity user;

  LoginSuccess({required this.user});
}

final class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}

final class LoginLoading extends LoginState {}
