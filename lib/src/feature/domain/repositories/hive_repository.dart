import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';

abstract class HiveRepository {
  Future<void> createSession(String id, String name);
  Future<List<SessionModel>> getAllSession();

  Future<void> addNewMessage(MessageModel message);
  Future<List<MessageModel>> getAllMessages(String sessionId);
}
