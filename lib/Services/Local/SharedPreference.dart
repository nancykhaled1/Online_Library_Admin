import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = "auth_token";
  static const String _userIdKey = "user_id";
  static const String _roleKey = "user_role";
  static const String _convIdKey = "conversation_id";


  ///////////////notification///////////////
  static Future<void> saveNotificationPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }

  static Future<bool> getNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true; // الافتراضى: مفتوح
  }





  // حفظ التوكن
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  // حفظ conversationId
  static Future<void> saveConvId(String convId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_convIdKey, convId);
  }

  // استرجاع التوكن
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // استرجاع الـ userId
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  // استرجاع الـ conversationId
  static Future<String?> getConvId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_convIdKey);
  }



  // مسح كل الداتا (مثلا عند اللوج آوت)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }



}
