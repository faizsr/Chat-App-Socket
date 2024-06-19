import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/session_list_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/chat_page.dart';
import 'package:flutter/material.dart';

class WideChatLayout extends StatefulWidget {
  const WideChatLayout({super.key});

  @override
  State<WideChatLayout> createState() => _WideChatLayoutState();
}

class _WideChatLayoutState extends State<WideChatLayout> {
  SessionModel? selectedSession;

  void _onSessionSelected(SessionModel session) {
    setState(() {
      selectedSession = session;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SessionListPage(
              onSessionSelected: _onSessionSelected,
            ),
          ),
          VerticalDivider(
            color: Colors.grey[300],
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: selectedSession != null
                ? ChatPage(session: selectedSession!)
                : const Center(
                    child: Text('Select a session to start chatting'),
                  ),
          )
        ],
      ),
    );
  }
}
