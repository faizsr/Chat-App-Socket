import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';

class SignUpUsecase {
  final FirebaseRepository firebaseRepository;

  SignUpUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.signUp(user);
  }
}
