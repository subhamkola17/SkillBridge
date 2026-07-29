import 'package:dio/dio.dart';

import '../models/internship_model.dart';
import 'api_service.dart';

class InternshipService {
  final Dio _dio = ApiService.dio;

  Future<List<Internship>> getInternships() async {
    try {
      final response = await _dio.get('/internships');

      final List list = response.data['internships'];

      return list
          .map((e) => Internship.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Failed to fetch internships',
      );
    } catch (e) {
      throw Exception('Failed to fetch internships');
    }
  }

  Future<Internship> getInternshipById(String id) async {
    try {
      final response = await _dio.get('/internships/$id');

      return Internship.fromJson(response.data['internship']);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Failed to fetch internship',
      );
    } catch (e) {
      throw Exception('Failed to fetch internship');
    }
  }

  Future<bool> applyInternship(String id) async {
    try {
      final response =
      await _dio.post('/internships/$id/apply');

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception(
            'You have already applied for this internship');
      }

      throw Exception(
        e.response?.data['message'] ??
            'Internship application failed',
      );
    } catch (e) {
      throw Exception('Internship application failed');
    }
  }
}