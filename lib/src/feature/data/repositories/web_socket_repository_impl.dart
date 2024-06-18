import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/network/web_socket_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';

class WebSocketRepositoryImpl extends WebSocketRepository {
  final WebSocketDataSource webSocketDataSource;

  WebSocketRepositoryImpl({required this.webSocketDataSource});
  @override
  Future<void> connectWebSocket() async {
    await webSocketDataSource.connectWebSocket();
  }

  @override
  Future<void> disconnectWebSocket() async {
    await webSocketDataSource.disconnectWebSocket();
  }

  @override
  Stream receiveMessage() {
    log('On web socket repository impl');
    return webSocketDataSource.receiveMessage();
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    await webSocketDataSource.sendMessage(message);
  }
}
