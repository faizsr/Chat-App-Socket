import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView(
        children: List.generate(
          10,
          (index) {
            return const ListTile(
              leading: CircleAvatar(radius: 25),
              title: Text('Username'),
              subtitle: Text('samplemail@gmail.com'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
