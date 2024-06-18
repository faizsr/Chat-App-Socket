import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';

class GetAllMessageUsecase {
  final HiveRepository hiveRepository;

  GetAllMessageUsecase({required this.hiveRepository});

  Future<List<MessageModel>> call(String sessionId) async {
    return hiveRepository.getAllMessages(sessionId);
  }
}
