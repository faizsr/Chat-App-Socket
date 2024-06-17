import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/auth/domain/repositories/firebase_repository.dart';

class SignUpUsecase {
  final FirebaseRepository firebaseRepository;

  SignUpUsecase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    log('Calling');
    return await firebaseRepository.signUp(user);
  }
}
