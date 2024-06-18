import 'package:chat_app_using_socket/src/feature/data/data_sources/local/hive_local_data_source.dart';
import 'package:chat_app_using_socket/src/feature/data/models/session/session_model.dart';
import 'package:chat_app_using_socket/src/feature/domain/repositories/hive_repository.dart';

class HiveRepositoryImpl extends HiveRepository {
  final HiveLocalDataSource hiveLocalDataSource;

  HiveRepositoryImpl({required this.hiveLocalDataSource});

  @override
  Future<void> createSession(String id, String name) async =>
      await hiveLocalDataSource.createSession(id, name);

  @override
  Future<List<SessionModel>> getAllSession() async =>
      await hiveLocalDataSource.getAllSession();
}
