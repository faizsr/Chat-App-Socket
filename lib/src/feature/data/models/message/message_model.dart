class MessageModel {
  final String userId;
  final String message;
  final String timeStamp;

  MessageModel({
    required this.userId,
    required this.message,
    required this.timeStamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      message: json['message'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'timeStamp': timeStamp.toString(),
    };
  }
}
