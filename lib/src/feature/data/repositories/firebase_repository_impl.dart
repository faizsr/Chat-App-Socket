import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> signIn(UserEntity user) async =>
      await firebaseRemoteDataSource.signInUser(user);

  @override
  Future<void> signUp(UserEntity user) async {
    log('Repository Calling');
    await firebaseRemoteDataSource.signUpUser(user);
  }
}
