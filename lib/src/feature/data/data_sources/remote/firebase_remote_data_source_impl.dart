import 'dart:developer';

import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/models/user/user_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  FirebaseRemoteDataSourceImpl({
    required this.fireStore,
    required this.auth,
  });

  @override
  Future<void> signUpUser(UserEntity user) async {
    // ========== Signing Up NewUser ==========
    await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);

    // ========== Creating Collection ==========
    final userCollection = fireStore.collection('users');
    final uid = auth.currentUser?.uid ?? 'newuser';

    userCollection.doc(uid).get().then(
      (userDoc) {
        final newUser = UserModel(
          fullName: user.fullName,
          email: user.email,
          password: user.password,
          profilePhote: user.email,
        ).toMap();

        if (!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
          log('User Added!!!');
        } else {
          userCollection.doc(uid).update(newUser);
          log('User Already Exists!!!');
        }
      },
    ).catchError((error) {
      log('Sign Up Error: $error');
    });
  }

  @override
  Future<void> signInUser(UserEntity user) async {
    print(user.password);
    print(user.email);
    await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }
}
