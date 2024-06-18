import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';

abstract class HiveRepository {
  Future<void> createSession(String id, String name);
  Future<List<SessionModel>> getAllSession();
}
