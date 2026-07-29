import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  // ===========================
  // LOGIN
  // ===========================

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final response = await ApiService.dio.post(
        "/auth/login",
        data: request.toJson(),
      );

      final token = response.data["token"];

      await ApiService.saveToken(token);

      return {
        "success": true,
        "user": UserModel.fromJson(response.data["user"]),
      };
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Login Failed",
      );
    }
  }

  // ===========================
  // REGISTER
  // ===========================

  Future<Map<String, dynamic>> register(
      RegisterRequest request) async {
    try {
      final response = await ApiService.dio.post(
        "/auth/register",
        data: request.toJson(),
      );

      final token = response.data["token"];

      await ApiService.saveToken(token);

      return {
        "success": true,
        "user": UserModel.fromJson(response.data["user"]),
      };
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Registration Failed",
      );
    }
  }

  // ===========================
  // GET PROFILE
  // ===========================

  Future<UserModel> getProfile() async {
    final response = await ApiService.dio.get("/auth/me");

    return UserModel.fromJson(response.data["user"]);
  }

  // ===========================
  // UPDATE PROFILE
  // ===========================

  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String experience,
    required String bio,
    required String skills,
  }) async {
    final response = await ApiService.dio.put(

      "/auth/profile",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
        "experience": experience,
        "bio": bio,
        "skills": skills
            .split(",")
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      },
    );

    return UserModel.fromJson(response.data["user"]);
  }

  // ===========================
  // LOGOUT
  // ===========================

  Future<void> logout() async {
    await ApiService.clearToken();
  }

  // ===========================
  // PROFILE IMAGE UPLOAD
  // ===========================

  Future<String> uploadProfileImage({
    XFile? file,
    Uint8List? bytes,
    required String fileName,
  }) async {
    try {
      FormData formData;

      if (kIsWeb) {
        formData = FormData.fromMap({
          "image": MultipartFile.fromBytes(
            bytes!,
            filename: fileName,
          ),
        });
      } else {
        formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            file!.path,
            filename: fileName,
          ),
        });
      }

      final response = await ApiService.dio.post(
        "/auth/upload-profile-image",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data["imageUrl"];
      }

      throw Exception(
        response.data["message"] ?? "Image upload failed",
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to upload profile image",
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}