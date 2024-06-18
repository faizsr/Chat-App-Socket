import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/local/hive_local_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class HiveLocalDataSourceImpl implements HiveLocalDataSource {
  final FirebaseAuth auth;

  HiveLocalDataSourceImpl({required this.auth});

  @override
  Future<void> createSession(String id, String name) async {
    final userId = auth.currentUser?.uid;

    final sessionBox = await Hive.openBox<SessionModel>('${userId}_session');
    final newSession = SessionModel(id: id, name: name, messages: []);
    log('New Session Box And Model Created!!!');

    sessionBox.put(id, newSession);
    log('Adding New Session To Box');
  }

  @override
  Future<List<SessionModel>> getAllSession() async {
    final userId = auth.currentUser?.uid;

    log('Retrieving all sessions');
    final sessionBox = await Hive.openBox<SessionModel>('${userId}_session');
    return sessionBox.values.toList();
  }

  @override
  Future<void> addNewMessage(MessageModel message) async {
    final messageBox =
        await Hive.openBox<MessageModel>('${message.sessionId}_messages');
    log('Adding new message to hive in box: ${message.sessionId}_messages');
    messageBox.add(message);
    log('After adding message length: ${messageBox.values.toList().length}');
  }

  @override
  Future<List<MessageModel>> getAllMessages(String sessionId) async {
    final messageBox =
        await Hive.openBox<MessageModel>('${sessionId}_messages');
    log('Get All Initial Messages ${messageBox.values.toList().length}');
    return messageBox.values.toList();
  }
}
