import 'dart:convert';

import 'package:lab1_counter/domain/models/user_model.dart';
import 'package:lab1_counter/domain/repositories/i_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthRepository implements IAuthRepository {
  static const String _usersKey = 'netpulse_users';
  static const String _currentUserKey = 'netpulse_current_user_email';

  Future<List<UserModel>> _loadUsers(SharedPreferences prefs) async {
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveUsers(
    SharedPreferences prefs,
    List<UserModel> users,
  ) async {
    final encoded = jsonEncode(users.map((u) => u.toJson()).toList());
    await prefs.setString(_usersKey, encoded);
  }

  @override
  Future<void> register(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    final normalizedEmail = user.email.trim().toLowerCase();

    final exists = users.any(
      (u) => u.email.trim().toLowerCase() == normalizedEmail,
    );
    if (exists) {
      throw Exception('Користувач із такою поштою вже існує');
    }

    final updatedUsers = [...users, user];
    await _saveUsers(prefs, updatedUsers);
    await prefs.setString(_currentUserKey, normalizedEmail);
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    final normalizedEmail = email.trim().toLowerCase();

    for (final user in users) {
      if (user.email.trim().toLowerCase() == normalizedEmail &&
          user.password == password) {
        await prefs.setString(_currentUserKey, normalizedEmail);
        return user;
      }
    }
    return null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentEmail = prefs.getString(_currentUserKey);
    if (currentEmail == null) {
      return null;
    }

    final users = await _loadUsers(prefs);
    for (final user in users) {
      if (user.email.trim().toLowerCase() == currentEmail) {
        return user;
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }
}
