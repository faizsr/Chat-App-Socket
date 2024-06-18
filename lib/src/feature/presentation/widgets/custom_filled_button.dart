import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btnText;
  final AuthState state;

  const CustomFilledButton(
      {super.key,
      required this.onPressed,
      required this.btnText,
      required this.state});

  @override
  Widget build(BuildContext context) {
    Widget child = Text(
      btnText,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
    if (state is SignInLoadingState || state is SignUpLoadingState) {
      child = Transform.scale(
        scale: 0.6,
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.white,
        ),
      );
    }

    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xFF0071bd),
      disabledColor: const Color(0xFF0071bd).withOpacity(0.5),
      onPressed: onPressed,
      child: child,
    );
  }
}
