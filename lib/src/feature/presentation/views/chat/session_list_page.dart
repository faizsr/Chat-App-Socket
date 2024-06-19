import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/widgets/session_list_appbar.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/widgets/session_list_tile.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: SessionListAppbar(textController: textController),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(),
            BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                if (state is GetAllSessionLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                if (state is GetAllSessionSucesssState) {
                  return Expanded(
                    child: state.sessions.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.sessions.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 5);
                            },
                            itemBuilder: (context, index) {
                              final session = state.sessions[index];
                              return SessionListTile(
                                widget: widget,
                                session: session,
                              );
                            },
                          )
                        : const Center(
                            child: Text('Session Empty! Create One'),
                          ),
                  );
                }
                return const Expanded(
                  child: Center(
                    child: Text('Session Empty! Create One'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget heading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: const Color(0xFF0071bd),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Sessions',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
