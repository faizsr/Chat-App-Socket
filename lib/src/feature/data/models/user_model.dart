import 'package:chat_app_using_socket/src/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.profilePhote,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      profilePhote: json['profilePhoto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullName,
      'email': email,
      'password': password,
      'profilePhoto': profilePhote,
    };
  }
}
