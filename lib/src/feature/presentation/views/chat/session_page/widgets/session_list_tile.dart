import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/chat_page/chat_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/session_page/session_list_page.dart';
import 'package:flutter/material.dart';

class SessionListTile extends StatelessWidget {
  const SessionListTile({
    super.key,
    required this.widget,
    required this.session,
  });

  final SessionListPage widget;
  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          if (MediaQuery.of(context).size.width > 700) {
            widget.onSessionSelected(session);
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                session: session,
                isPhone: true,
              ),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF0071bd).withOpacity(0.1),
                radius: 28,
                child: Text(
                  session.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                session.name,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
