import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/chat_list_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_up/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: authBlocListener,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    final user = UserEntity(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    BlocProvider.of<AuthBloc>(context)
                        .add(SignInEvent(user: user));
                  },
                  child: const Text('Sign In'),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ));
                  },
                  child: const Text("Don't have an account? Sign Up?"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authBlocListener(BuildContext context, AuthState state) {
    if (state is SignInSuccessState) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ChatListPage(),
      ));
      log('Sign In Success Navigating to Chat List Page');
    }
  }
}
