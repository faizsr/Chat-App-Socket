import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';

class CreateSessionUsecase {
  final HiveRepository hiveRepository;

  CreateSessionUsecase({required this.hiveRepository});

  Future<void> call(String id, String name) async {
    await hiveRepository.createSession(id, name);
  }
}
