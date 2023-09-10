import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool isFirstTime = true;
  Auth() {
    checkAuth();
  }
  checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirstTime') == null) {
      return;
    } else {
      isFirstTime = prefs.getBool('isFirstTime')!;
    }
  }
}
