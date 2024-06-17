part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpLoadingState extends AuthState {}

final class SignUpSuccessState extends AuthState {}

final class SignUpErrorState extends AuthState {}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {}

final class SignInErrorState extends AuthState {}
