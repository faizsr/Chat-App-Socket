import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';

class GetAllSessionUsecase {
  final HiveRepository hiveRepository;

  GetAllSessionUsecase({required this.hiveRepository});

  Future<List<SessionModel>> call() async {
    return await hiveRepository.getAllSession();
  }
}
