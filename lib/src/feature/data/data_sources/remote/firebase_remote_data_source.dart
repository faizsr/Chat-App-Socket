import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUpUser(UserEntity user);

  Future<void> signInUser(UserEntity user);
}
