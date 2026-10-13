import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran_tahfez/features/auth/data/models/user_model.dart';
import 'package:quran_tahfez/features/auth/domain/entities/user_entity.dart';

class PrefsHelper {
  static late SharedPreferences _prefs;

  static const String _userKey = 'user_data';

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== String ====================

  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // ==================== Int ====================

  static Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // ==================== User ====================

  static Future<bool> saveUser(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      createdAt: user.createdAt,
      isActive: user.isActive,
    );

    return await _prefs.setString(
      _userKey,
      jsonEncode(userModel.toMap()),
    );
  }

  static UserEntity? getUser() {
    final userData = _prefs.getString(_userKey);

    if (userData == null) return null;

    try {
      final Map<String, dynamic> map =
          jsonDecode(userData) as Map<String, dynamic>;

      return UserModel.fromMap(map).toEntity();
    } catch (_) {
      return null;
    }
  }

  static bool isLoggedIn() {
    return getUser()?.id != null;
  }

  // ==================== Clear ====================

  static Future<bool> clearUser() async {
    return await _prefs.remove(_userKey);
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
