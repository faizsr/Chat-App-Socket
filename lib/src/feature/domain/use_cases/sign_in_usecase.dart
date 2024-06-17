import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository firebaseRepository;

  SignInUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.signIn(user);
  }
}
