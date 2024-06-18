import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';

abstract class WebSocketDataSource {
  Future<void> connectWebSocket();
  Future<void> disconnectWebSocket();
  Future<void> sendMessage(MessageModel message);
  Stream receiveMessage();
}
