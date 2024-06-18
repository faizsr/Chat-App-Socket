part of 'websocket_bloc.dart';

@immutable
sealed class WebsocketState {}

final class WebsocketInitial extends WebsocketState {}

final class WebSocketConnectedState extends WebsocketState {}
final class WebSocketConnectingState extends WebsocketState {}

final class WebSocketDisconnectedState extends WebsocketState {}

final class MessageReceivedState extends WebsocketState {
  final List<MessageModel> messages;

  MessageReceivedState({
    required this.messages,
  });
}

