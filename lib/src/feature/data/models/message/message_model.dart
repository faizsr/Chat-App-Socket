import 'package:hive_flutter/hive_flutter.dart';

part 'message_model.g.dart';

@HiveType(typeId: 1)
class MessageModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String sessionId;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final String timeStamp;

  MessageModel({
    required this.userId,
    required this.sessionId,
    required this.message,
    required this.timeStamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      sessionId: json['sessionId'],
      message: json['message'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'sessionId': sessionId,
      'message': message,
      'timeStamp': timeStamp.toString(),
    };
  }
}
