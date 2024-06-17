part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final UserEntity user;

  SignUpEvent({required this.user});
}

final class SignInEvent extends AuthEvent {
  final UserEntity user;

  SignInEvent({required this.user});
}
