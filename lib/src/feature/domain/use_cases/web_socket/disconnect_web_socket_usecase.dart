import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';

class DisconnectWebSocketUsecase {
  final WebSocketRepository webSocketRepository;

  DisconnectWebSocketUsecase({required this.webSocketRepository});

  Future<void> call() async {
    webSocketRepository.disconnectWebSocket();
  }
}
