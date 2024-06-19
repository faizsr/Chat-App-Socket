import 'dart:developer';

import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/config/utils/validation.dart';
import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/session_list_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/wide_chat_layout.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/responsive_widget.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_up/sign_up_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_filled_button.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_text_button.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_text_field.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isPhone = constraints.maxWidth < 600;

            return BlocConsumer<AuthBloc, AuthState>(
              listener: authBlocListener,
              builder: (context, state) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    constraints: BoxConstraints(
                      maxWidth: isPhone ? double.infinity : 550,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Welcome Back !!',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            validator: emailValidator,
                            controller: emailController,
                            hintText: 'Email Address',
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            validator: passwordValidator,
                            controller: passwordController,
                            hintText: 'Password',
                          ),
                          const SizedBox(height: 20),
                          CustomFilledButton(
                            state: state,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final user = UserEntity(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                BlocProvider.of<AuthBloc>(context)
                                    .add(SignInEvent(user: user));
                              }
                            },
                            btnText: 'Sign In',
                          ),
                          const Spacer(),
                          CustomTextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ));
                            },
                            btnText: "Don't have an account? Sign Up?",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void authBlocListener(BuildContext context, AuthState state) {
    if (state is SignInSuccessState) {
      log('Sign In Success Navigating to Chat List Page');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ResponsiveWidget(
          smallScreen: SessionListPage(onSessionSelected: (val) {}),
          largeScreen: const WideChatLayout(),
        ),
      ));
      UserAuthStatus.saveUserStatus(true);
    }
  }
}
