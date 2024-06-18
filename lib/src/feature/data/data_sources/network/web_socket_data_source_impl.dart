import 'dart:convert';
import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/network/web_socket_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDataSourceImpl implements WebSocketDataSource {
  WebSocketChannel? _channel;

  @override
  Future<void> connectWebSocket() async {
    _channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
  }

  @override
  Future<void> disconnectWebSocket() async {
    _channel?.sink.close();
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final messageJson = jsonEncode(message.toMap());
    _channel?.sink.add(messageJson);
  }

  @override
  Stream receiveMessage() {
    log('Returning stream from data source');
    return _channel!.stream;
  }
}
