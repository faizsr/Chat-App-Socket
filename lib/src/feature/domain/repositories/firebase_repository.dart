import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> signUp(UserEntity user);
  Future<void> signIn(UserEntity user);
  Future<void> signOut();
}
