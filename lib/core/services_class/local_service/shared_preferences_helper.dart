// Your existing SharedPreferencesHelper class
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';
  static const String _userTypeKey = 'userType';

  // Save access token
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setBool('isLogin', true);
    if (kDebugMode) {
      print('Token saved: $token');
      print('isLogin saved: true');
    }
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Clear access token
  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey); // Clear the token
    await prefs.remove(_userTypeKey); // Clear the role
    await prefs.remove('isLogin'); // Clear the login status
    if (kDebugMode) {
      print('All data cleared from SharedPreferences.');
    }
  }

  static Future<String?> getPickerLocationUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pickerLocationUuid');
  }

  // Clear access token
  static Future<void> clearAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove('isLogin');
    if (kDebugMode) {
      print('Access token cleared from SharedPreferences.');
    }
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  // Save user type
  static Future<void> saveUserType(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, userType);
    if (kDebugMode) {
      print('User type saved: $userType');
    }
  }

  // Retrieve user type
  static Future<String?> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }
}
