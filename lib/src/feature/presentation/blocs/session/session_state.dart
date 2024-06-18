part of 'session_bloc.dart';

@immutable
sealed class SessionState {}

final class SessionInitial extends SessionState {}

final class CreateSessionLoadingState extends SessionState {}

final class CreateSessionSuccessState extends SessionState {}

final class CreateSessionErrorState extends SessionState {}

final class GetAllSessionLoadingState extends SessionState {}

final class GetAllSessionSucesssState extends SessionState {
  final List<SessionModel> sessions;

  GetAllSessionSucesssState({required this.sessions});
}

final class GetAllSessionErrorState extends SessionState {}
