import 'package:dio/dio.dart';

import '../models/mentor_model.dart';
import 'api_service.dart';

class MentorService {
  final Dio _dio = ApiService.dio;

  Future<List<Mentor>> getMentors() async {
    try {
      final response = await _dio.get('/mentors');

      final List list = response.data['mentors'];

      return list.map((e) => Mentor.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch mentors: $e');
    }
  }

  Future<Mentor> getMentorById(String id) async {
    try {
      final response = await _dio.get('/mentors/$id');

      return Mentor.fromJson(response.data['mentor']);
    } catch (e) {
      throw Exception('Failed to fetch mentor details: $e');
    }
  }

  Future<void> bookMentor(String id) async {
    try {
      await _dio.post('/mentors/$id/book');
    } on DioException {
      rethrow;
    }
  }

  Future<void> applyForMentor({
    required String name,
    required String designation,
    required String company,
    required String expertise,
    required String experience,
    required String bio,
    required List<String> skills,
    required List<String> languages,
    required double fee,
    required List<String> availableDays,
    required List<String> availableSlots,
    required String linkedin,
    String profileImage = "",
    String resume = "",
  }) async {
    try {
      await _dio.post(
        '/mentors/apply',
        data: {
          "name": name,
          "designation": designation,
          "company": company,
          "expertise": expertise,
          "experience": experience,
          "bio": bio,
          "skills": skills,
          "languages": languages,
          "fee": fee,
          "availableDays": availableDays,
          "availableSlots": availableSlots,
          "linkedin": linkedin,
          "profileImage": profileImage,
          "resume": resume,
        },
      );
    } on DioException {
      rethrow;
    }
  }

  Future<List<Mentor>> getPendingMentors() async {
    try {
      final response = await _dio.get('/mentors/pending');

      final List list = response.data['mentors'];

      return list.map((e) => Mentor.fromJson(e)).toList();
    } on DioException {
      rethrow;
    }
  }

  Future<void> approveMentor(String id) async {
    try {
      await _dio.put('/mentors/$id/approve');
    } on DioException {
      rethrow;
    }
  }

  Future<void> rejectMentor(String id) async {
    try {
      await _dio.put('/mentors/$id/reject');
    } on DioException {
      rethrow;
    }
  }

}