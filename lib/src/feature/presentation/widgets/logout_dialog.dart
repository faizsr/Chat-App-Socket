import 'package:chat_app_using_socket/src/feature/data/data_sources/local/sf_auth_status.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/views/sign_in/sign_in_page.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    // ========== On Logout Pressed ==========
    void onLogoutPressed() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ));
      UserAuthStatus.saveUserStatus(false);
      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
      BlocProvider.of<WebsocketBloc>(context).add(DisconnectWebSocketEvent());
    }

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Confirm Logout',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DialogButton(
                        color: const Color(0xFF0071bd).withOpacity(0.1),
                        context: context,
                        text: 'Cancel',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DialogButton(
                        context: context,
                        color: const Color(0xFF0071bd),
                        onTap: onLogoutPressed,
                        text: 'Logout',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
