import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/chat_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/widgets/create_session_dialog.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionListPage extends StatefulWidget {
  final Function(SessionModel) onSessionSelected;

  const SessionListPage({
    super.key,
    required this.onSessionSelected,
  });

  @override
  State<SessionListPage> createState() => _SessionListPageState();
}

class _SessionListPageState extends State<SessionListPage> {
  final textController = TextEditingController();

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
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              BlocProvider.of<WebsocketBloc>(context)
                  .add(DisconnectWebSocketEvent());
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
          CreateSession.showCreateDialog(context, textController);
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
