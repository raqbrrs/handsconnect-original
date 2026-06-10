import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../data/database_helper.dart';
import '../models/user_model.dart';

class AuthService {
  static final AuthService instance = AuthService._init();
  UserModel? _currentUser;

  AuthService._init();

  UserModel? get currentUser => _currentUser;

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<bool> register(String username, String email, String password) async {
    final db = await DatabaseHelper.instance.database;
    try {
      await db.insert('users', {
        'username': username,
        'email': email,
        'password_hash': _hashPassword(password)
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, _hashPassword(password)],
    );

    if (maps.isNotEmpty) {
      _currentUser = UserModel.fromMap(maps.first);
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
  }
}
