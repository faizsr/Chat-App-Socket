import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';

class ConnectWebSocketUsecase {
  final WebSocketRepository webSocketRepository;

  ConnectWebSocketUsecase({required this.webSocketRepository});

  Future<void> call() async {
    webSocketRepository.connectWebSocket();
  }
}
