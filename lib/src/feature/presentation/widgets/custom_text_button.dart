import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btnText;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black45,
        ),
      ),
    );
  }
}
