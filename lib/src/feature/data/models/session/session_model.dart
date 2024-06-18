import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:hive/hive.dart';
part 'session_model.g.dart';

@HiveType(typeId: 0)
class SessionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<MessageModel>? messages;

  SessionModel({
    required this.id,
    required this.name,
    this.messages,
  });
}
