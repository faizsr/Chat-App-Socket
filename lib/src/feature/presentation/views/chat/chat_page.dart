import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final SessionModel? session;
  final bool isPhone;
  const ChatPage({
    super.key,
    this.session,
    this.isPhone = false,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WebsocketBloc>(context)
        .add(GetInitialMessageEvent(sessionId: widget.session!.id));
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 1,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(widget.session?.name ?? ''),
        leading: widget.isPhone
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.arrow_left),
              )
            : null,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(
            color: Colors.black12,
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<WebsocketBloc, WebsocketState>(
            builder: (context, state) {
              if (state is MessageReceivedState) {
                log('Message Received Length: ${state.messages.length}');
                state.messages;
                return ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: index % 2 == 0
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Text(state.messages[index].message),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageTextController,
                      decoration: const InputDecoration(
                        hintText: 'Write here...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final message = MessageModel(
                        sessionId: widget.session!.id,
                        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                        message: messageTextController.text,
                        timeStamp: DateTime.now().toString(),
                      );
                      log('Message: ${message.userId}, ${message.message}, ${message.timeStamp}');

                      BlocProvider.of<WebsocketBloc>(context)
                          .add(SendMessageEvent(message: message));

                      messageTextController.clear();
                    },
                    icon: const Icon(CupertinoIcons.arrow_right),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
