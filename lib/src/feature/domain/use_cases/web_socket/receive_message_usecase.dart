import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';

class ReceiveMessageUsecase {
  final WebSocketRepository webSocketRepository;

  ReceiveMessageUsecase({required this.webSocketRepository});

  Stream call() {
    return webSocketRepository.receiveMessage();
  }
}
