import 'package:flutter/material.dart';

import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  UserModel? user;

  bool loading = false;

  Future<bool> login(
      String email,
      String password,
      ) async {
    loading = true;
    notifyListeners();

    try {
      final result = await _service.login(
        LoginRequest(
          email: email,
          password: password,
        ),
      );

      user = result["user"];

      loading = false;

      notifyListeners();

      return true;
    } catch (e) {
      print("REGISTER ERROR: $e");

      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(
      String name,
      String email,
      String password,
      String role,
      ) async {
    loading = true;

    notifyListeners();

    try {
      final result = await _service.register(
        RegisterRequest(
          name: name,
          email: email,
          password: password,
          role: role,
        ),
      );

      user = result["user"];

      loading = false;

      notifyListeners();

      return true;
    } catch (_) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _service.logout();

    user = null;

    notifyListeners();
  }
}