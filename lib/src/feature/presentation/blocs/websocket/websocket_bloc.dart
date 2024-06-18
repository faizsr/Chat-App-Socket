import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/connect_web_socket_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/disconnect_web_socket_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/receive_message_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/send_message_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final ConnectWebSocketUsecase connectWebSocketUsecase;
  final DisconnectWebSocketUsecase disconnectWebSocketUsecase;
  final SendMessageUsecase sendMessageUsecase;
  final ReceiveMessageUsecase receiveMessageUsecase;

  final List<MessageModel> _messages = [];

  WebsocketBloc({
    required this.connectWebSocketUsecase,
    required this.disconnectWebSocketUsecase,
    required this.sendMessageUsecase,
    required this.receiveMessageUsecase,
  }) : super(WebsocketInitial()) {
    on<ConnectWebSocketEvent>(connectWebSocketEvent);
    on<DisconnectWebSocketEvent>(disconnectWebSocketEvent);
    on<SendMessageEvent>(sendMessageEvent);
    on<ReceiveMessaegEvent>(receiveMessaegEvent);
  }

  FutureOr<void> connectWebSocketEvent(
      ConnectWebSocketEvent event, Emitter<WebsocketState> emit) async {
    emit(WebSocketConnectingState());
    await connectWebSocketUsecase.call();
    log('Socket Connected');
    emit(WebSocketConnectedState());

    log('Receive Message Event Calling');
    Stream stream = receiveMessageUsecase.call();

    stream.listen((message) async {
      log('Event data: $message');
      if (message is String && !message.contains('Request served')) {
        final jsonMessage = jsonDecode(message);
        log('Runtime Type: ${jsonMessage.runtimeType}');

        final newMessage = MessageModel.fromJson(jsonMessage);
        log('Message map: ${newMessage.toMap()}');
        add(ReceiveMessaegEvent(message: newMessage));
      }
    });
  }

  FutureOr<void> disconnectWebSocketEvent(
      DisconnectWebSocketEvent event, Emitter<WebsocketState> emit) async {
    await disconnectWebSocketUsecase.call();
    emit(WebSocketDisconnectedState());
  }

  FutureOr<void> sendMessageEvent(
      SendMessageEvent event, Emitter<WebsocketState> emit) async {
    await sendMessageUsecase.call(event.message);
    _messages.add(event.message);
    log('is closed $isClosed');
    emit(MessageReceivedState(messages: _messages));
  }

  FutureOr<void> receiveMessaegEvent(
      ReceiveMessaegEvent event, Emitter<WebsocketState> emit) async {
    _messages.add(event.message);
    log('is closed $isClosed');
    emit(MessageReceivedState(messages: _messages));
  }
}
