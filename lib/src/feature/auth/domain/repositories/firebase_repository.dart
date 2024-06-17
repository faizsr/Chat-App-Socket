import 'package:chat_app_using_socket/src/feature/auth/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> signUp(UserEntity user);
  Future<void> signIn(UserEntity user);
}
