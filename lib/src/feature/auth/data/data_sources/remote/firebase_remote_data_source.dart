import 'package:chat_app_using_socket/src/feature/auth/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUpUser(UserEntity user);

  Future<void> signInUser(UserEntity user);
}
