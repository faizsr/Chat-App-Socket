import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/local/hive_local_data_source.dart';
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
}
