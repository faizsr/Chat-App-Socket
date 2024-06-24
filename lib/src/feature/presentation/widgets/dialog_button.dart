import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final Color color;
  final void Function()? onTap;

  const DialogButton({
    super.key,
    required this.context,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 45,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        highlightColor: Colors.grey[200],
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: text == 'Cancel' ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
