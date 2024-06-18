import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInPage(),
      ),
    );
  }
}
