part of 'session_bloc.dart';

@immutable
sealed class SessionEvent {}

final class CreateSessionEvent extends SessionEvent {
  final String id;
  final String name;

  CreateSessionEvent({
    required this.id,
    required this.name,
  });
}

final class GetAllSessionEvent extends SessionEvent {}
