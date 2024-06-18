import 'dart:developer';

import 'package:chat_app_using_socket/src/config/utils/auth_status.dart';
import 'package:chat_app_using_socket/src/config/utils/validation.dart';
import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/chats/chat_list_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_filled_button.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_text_button.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isPhone = constraints.maxWidth < 600;

            return BlocConsumer<AuthBloc, AuthState>(
              listener: authListener,
              builder: (context, state) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    constraints: BoxConstraints(
                      maxWidth: isPhone ? double.infinity : 550,
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create Account?',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            validator: nameValidator,
                            controller: nameController,
                            hintText: 'Full name',
                          ),
                          const SizedBox(height: 15),
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
                              if (formkey.currentState!.validate()) {
                                final user = UserEntity(
                                  fullName: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  profilePhote: nameController.text[0],
                                );

                                BlocProvider.of<AuthBloc>(context)
                                    .add(SignUpEvent(user: user));
                              }
                            },
                            btnText: 'Sign In',
                          ),
                          const Spacer(),
                          CustomTextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            btnText: "Already have an account? Sign In?",
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

  void authListener(BuildContext context, AuthState state) {
    if (state is SignUpSuccessState) {
      log('Sign Up Success Navigating to Chat List Page');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ChatListPage(),
      ));
      UserAuthStatus.saveUserStatus(true);
    }
  }
}
