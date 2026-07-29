import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // static const String baseUrl = "http://10.0.2.2:5000/api";
  // If running on Chrome, change to:
   static const String baseUrl = "http://localhost:5000/api";

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);

    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");

    dio.options.headers.remove("Authorization");
  }
}