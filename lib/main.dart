import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/session_list_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/wide_chat_layout.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chat/responsive_widget.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  dynamic page = const SignInPage();

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  Future<void> checkUserStatus() async {
    isLoggedIn = await UserAuthStatus.getUserStatus();
    if (isLoggedIn) {
      page = ResponsiveWidget(
        smallScreen: SessionListPage(onSessionSelected: (val) {}),
        largeScreen: const WideChatLayout(),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<SessionBloc>(
          create: (context) => di.sl<SessionBloc>(),
        ),
        BlocProvider<WebsocketBloc>(
          create: (context) => di.sl<WebsocketBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App Using Socket',
        theme: ThemeData(
          fontFamily: 'NetflixSans',
          scaffoldBackgroundColor: Colors.white,
        ),
        home: page,
      ),
    );
  }
}
