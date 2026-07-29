import 'package:dio/dio.dart';

import '../models/job_model.dart';
import 'api_service.dart';

class JobService {
  final Dio _dio = ApiService.dio;

  /// Get all jobs
  Future<List<Job>> getJobs() async {
    try {
      final response = await _dio.get('/jobs');

      final List jobs = response.data['jobs'];

      return jobs.map((e) => _jobFromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch jobs: $e");
    }
  }

  /// Get single job
  Future<Job> getJobById(String id) async {
    try {
      final response = await _dio.get('/jobs/$id');

      return _jobFromJson(response.data['job']);
    } catch (e) {
      throw Exception("Failed to fetch job: $e");
    }
  }

  /// Apply for a job
  Future<bool> applyJob(String jobId) async {
    try {
      final response = await _dio.post('/jobs/$jobId/apply');

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } catch (e) {
      if (e is DioException) {
        throw e;
      }

      throw Exception("Job application failed");
    }
  }

  Job _jobFromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      salary: json['salary']?.toString() ?? '',
      experience: json['experience'] ?? '',
      jobType: json['type'] ?? '',
      postedDate: json['deadline'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      isRemote: json['location'] == "Remote",
      isSaved: false,
    );
  }
}