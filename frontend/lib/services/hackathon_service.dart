import 'package:dio/dio.dart';

import '../models/hackathon_model.dart';
import 'api_service.dart';

class HackathonService {
  final Dio _dio = ApiService.dio;

  Future<List<Hackathon>> getHackathons() async {
    try {
      final response = await _dio.get('/hackathons');

      final List list = response.data['hackathons'];

      return list
          .map((e) => Hackathon.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch hackathons: $e');
    }
  }

  Future<Hackathon> getHackathonById(String id) async {
    try {
      final response = await _dio.get('/hackathons/$id');

      return Hackathon.fromJson(response.data['hackathon']);
    } catch (e) {
      throw Exception('Failed to fetch hackathon details: $e');
    }
  }

  Future<void> applyHackathon(String id) async {
    try {
      await _dio.post('/hackathons/$id/apply');
    } on DioException catch (e) {
      rethrow;
    }
  }
}