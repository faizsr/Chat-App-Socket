import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';

class SendMessageUsecase {
  final WebSocketRepository webSocketRepository;

  SendMessageUsecase({required this.webSocketRepository});

  Future<void> call(MessageModel message) async {
    webSocketRepository.sendMessage(message);
  }
}
