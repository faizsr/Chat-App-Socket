import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';

class AddNewMessageUsecase {
  final HiveRepository hiveRepository;

  AddNewMessageUsecase({required this.hiveRepository});

  Future<void> call(MessageModel message) async {
    await hiveRepository.addNewMessage(message);
  }
}
