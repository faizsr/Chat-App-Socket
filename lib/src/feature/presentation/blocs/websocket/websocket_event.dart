part of 'websocket_bloc.dart';

@immutable
sealed class WebsocketEvent {}

final class ConnectWebSocketEvent extends WebsocketEvent {}

final class DisconnectWebSocketEvent extends WebsocketEvent {}

final class SendMessageEvent extends WebsocketEvent {
  final MessageModel message;

  SendMessageEvent({
    required this.message,
  });
}

final class ReceiveMessaegEvent extends WebsocketEvent {
  final MessageModel message;

  ReceiveMessaegEvent({
    required this.message,
  });
}
