import 'package:chat_app_using_socket/firebase_options.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/local/hive_local_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/local/hive_local_data_source_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/network/web_socket_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/network/web_socket_data_source_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/data_sources/remote/firebase_remote_data_source_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/models/message/message_model.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/data/repositories/firebase_repository_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/repositories/hive_repository_impl.dart';
import 'package:chat_app_using_socket/src/feature/data/repositories/web_socket_repository_impl.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/firebase_repository.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/web_socket_repository.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/auth/sign_in_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/auth/sign_out_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/auth/sign_up_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/chat/add_new_message_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/chat/get_all_message.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/session/create_session_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/session/get_session_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/connect_web_socket_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/disconnect_web_socket_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/receive_message_usecase.dart';
import 'package:chat_app_using_socket/src/feature/domain/use_cases/web_socket/send_message_usecase.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/auth/auth_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/session/session_bloc.dart';
import 'package:chat_app_using_socket/src/feature/presentation/blocs/websocket/websocket_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Initialize Hive
  await Hive.initFlutter();
  //Register Hive Adapter
  Hive.registerAdapter(SessionModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());

  //Future bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
      signOutUsecase: sl.call(),
    ),
  );
  sl.registerFactory<SessionBloc>(
    () => SessionBloc(
      createSessionUsecase: sl.call(),
      getAllSessionUsecase: sl.call(),
    ),
  );
  sl.registerFactory<WebsocketBloc>(
    () => WebsocketBloc(
      connectWebSocketUsecase: sl.call(),
      disconnectWebSocketUsecase: sl.call(),
      sendMessageUsecase: sl.call(),
      receiveMessageUsecase: sl.call(),
      addNewMessageUsecase: sl.call(),
      getAllMessageUsecase: sl.call(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<CreateSessionUsecase>(
      () => CreateSessionUsecase(hiveRepository: sl.call()));
  sl.registerLazySingleton<GetAllSessionUsecase>(
      () => GetAllSessionUsecase(hiveRepository: sl.call()));

  sl.registerLazySingleton<AddNewMessageUsecase>(
      () => AddNewMessageUsecase(hiveRepository: sl.call()));
  sl.registerLazySingleton<GetAllMessageUsecase>(
      () => GetAllMessageUsecase(hiveRepository: sl.call()));

  sl.registerLazySingleton<ConnectWebSocketUsecase>(
      () => ConnectWebSocketUsecase(webSocketRepository: sl.call()));
  sl.registerLazySingleton<DisconnectWebSocketUsecase>(
      () => DisconnectWebSocketUsecase(webSocketRepository: sl.call()));
  sl.registerLazySingleton<SendMessageUsecase>(
      () => SendMessageUsecase(webSocketRepository: sl.call()));
  sl.registerLazySingleton<ReceiveMessageUsecase>(
      () => ReceiveMessageUsecase(webSocketRepository: sl.call()));

  //Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));
  sl.registerLazySingleton<HiveRepository>(
      () => HiveRepositoryImpl(hiveLocalDataSource: sl.call()));
  sl.registerLazySingleton<WebSocketRepository>(
      () => WebSocketRepositoryImpl(webSocketDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()));

  //Local DataSource
  sl.registerLazySingleton<HiveLocalDataSource>(
      () => HiveLocalDataSourceImpl(auth: sl.call()));

  //Websocket DataSource
  sl.registerLazySingleton<WebSocketDataSource>(
      () => WebSocketDataSourceImpl());

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
