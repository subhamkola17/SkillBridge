import '../models/dashboard_stats.dart';
import 'api_service.dart';

class DashboardService {
  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await ApiService.dio.get("/dashboard");

      if (response.statusCode == 200 &&
          response.data["success"] == true) {
        return DashboardStats.fromJson(
          response.data["stats"],
        );
      }

      throw Exception(
        response.data["message"] ??
            "Failed to load dashboard statistics",
      );
    } catch (e) {
      throw Exception("Dashboard Error: $e");
    }
  }
}