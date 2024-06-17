import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Future bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(firebaseRepository: sl.call()));

  //Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()),
  );

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
