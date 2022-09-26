import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  void loginUser(String userName) {
    try {
      _prefs.setString('userName', userName);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isLoggedIn() async {
    String? userName = await _prefs.getString("userName");
    if (userName == null) return false;
    return true;
  }

  void logoutUser() {
    try {
      _prefs.clear();
    } catch (e) {
      print(e);
    }
  }

  String? getUserName() {
    return _prefs.getString('userName') ?? "sumith";
  }

  void updateUserName(String newName) {
    try {
      _prefs.setString('userName', newName);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
