import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/chats_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    BlocProvider.of<SessionBloc>(context).add(GetAllSessionEvent());
    BlocProvider.of<WebsocketBloc>(context).add(ConnectWebSocketEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ));
              UserAuthStatus.saveUserStatus(false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is GetAllSessionSucesssState) {
            return ListView.builder(
              itemCount: state.sessions.length,
              itemBuilder: (context, index) {
                final session = state.sessions[index];
                return ListTile(
                  leading: const CircleAvatar(radius: 25),
                  title: Text(session.name),
                  subtitle: Text(session.id),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatsPage(session: session),
                    ));
                  },
                );
              },
            );
          }
          return const Center(
            child: Text('Session Empty! Create One'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final id = DateTime.now().millisecondsSinceEpoch.toString();
          BlocProvider.of<SessionBloc>(context)
            ..add(CreateSessionEvent(id: id, name: 'Session 6'))
            ..add(GetAllSessionEvent());
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
