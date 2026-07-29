import 'package:dio/dio.dart';

import '../services/api_service.dart';
import '../models/booking_model.dart';

class BookingService {
  final Dio _dio = ApiService.dio;

  // Create Booking
  Future<Map<String, dynamic>> createBooking({
    required String mentorId,
    required String bookingDate,
    required String timeSlot,
    required int duration,
    required String sessionType,
    required String notes,
    required double amount,
  }) async {
    try {
      final response = await _dio.post(
        "/bookings",
        data: {
          "mentorId": mentorId,
          "bookingDate": bookingDate,
          "timeSlot": timeSlot,
          "duration": duration,
          "sessionType": sessionType,
          "notes": notes,
          "amount": amount,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Booking failed",
      );
    }
  }

  // Student Bookings
  Future<List<BookingModel>> getMyBookings() async {
    try {
      final response = await _dio.get("/bookings/my");

      return (response.data["bookings"] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Unable to fetch bookings",
      );
    }
  }

  // Mentor Bookings
  Future<List<dynamic>> getMentorBookings() async {
    try {
      final response = await _dio.get("/bookings/mentor");

      return response.data["bookings"];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Unable to fetch mentor bookings",
      );
    }
  }

  Future<void> acceptBooking(String bookingId) async {
    await _dio.put("/bookings/$bookingId/accept");
  }

  Future<void> rejectBooking(String bookingId) async {
    await _dio.put("/bookings/$bookingId/reject");
  }

  Future<void> cancelBooking(String bookingId) async {
    await _dio.put("/bookings/$bookingId/cancel");
  }

  Future<void> completeBooking(String bookingId) async {
    await _dio.put("/bookings/$bookingId/complete");
  }
}