import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';

abstract class HiveLocalDataSource {
  Future<void> createSession(String id, String name);
  Future<List<SessionModel>> getAllSession();
}
