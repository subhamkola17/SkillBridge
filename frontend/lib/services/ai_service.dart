import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AIService {
  static const String baseUrl = "http://localhost:5000/api";

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getRecommendation({
    required String skills,
    required String interests,
    required String goal,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _dio.post(
        "$baseUrl/ai/recommend",
        data: {
          "skills": skills,
          "interests": interests,
          "goal": goal,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response?.data["message"] ?? "Something went wrong",
        );
      } else {
        throw Exception("Unable to connect to server");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}