import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSession {
  static void showCreateDialog(
    BuildContext context,
    TextEditingController textController,
  ) {
    void onCreatePressed() {
      final id = "${DateTime.now().millisecondsSinceEpoch}";
      BlocProvider.of<SessionBloc>(context)
        ..add(CreateSessionEvent(id: id, name: textController.text))
        ..add(GetAllSessionEvent());
      Navigator.of(context).pop();
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
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Create Session',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: CustomTextField(
                  controller: textController,
                  hintText: 'Session name',
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: actionButton(
                        color: const Color(0xFF0071bd).withOpacity(0.1),
                        context: context,
                        text: 'Cancel',
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: actionButton(
                        context: context,
                        color: const Color(0xFF0071bd),
                        onTap: onCreatePressed,
                        text: 'Create',
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

  static Container actionButton({
    required BuildContext context,
    required String text,
    required Color color,
    required void Function()? onTap,
  }) {
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
