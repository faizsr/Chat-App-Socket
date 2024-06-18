import 'package:shared_preferences/shared_preferences.dart';

class UserAuthStatus {
  static Future<bool> getUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? status = preferences.getBool('SIGNIN');
    return status ?? false;
  }

  static saveUserStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('SIGNIN', status);
  }
}
