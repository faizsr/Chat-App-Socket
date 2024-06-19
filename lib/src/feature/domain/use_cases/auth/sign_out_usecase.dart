import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository firebaseRepository;

  SignOutUsecase({required this.firebaseRepository});

  Future<void> call() async {
    return await firebaseRepository.signOut();
  }
}
