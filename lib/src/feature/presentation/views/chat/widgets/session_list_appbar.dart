import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/widgets/create_session_dialog.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionListAppbar extends StatelessWidget {
  const SessionListAppbar({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 75,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!['fullname']
                          .toString()
                          .split(' ')
                          .toList()[0],
                      style: const TextStyle(fontSize: 25),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              CreateSession.showCreateDialog(context, textController);
            },
            icon: const Icon(CupertinoIcons.add, size: 25),
          ),
          const SizedBox(width: 5),
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
    );
  }
}
