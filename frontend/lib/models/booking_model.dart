import 'mentor_model.dart';

class BookingModel {
  final String id;
  final String? student;
  final Mentor mentor;
  final DateTime date;
  final String time;
  final int duration;
  final String sessionType;
  final String notes;
  final int amount;
  final String? status;
  final String? meetingId;
  final String? meetingRoomId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BookingModel({
    required this.id,
    this.student,
    required this.mentor,
    required this.date,
    required this.time,
    required this.duration,
    required this.sessionType,
    required this.notes,
    required this.amount,
    this.status,
    this.meetingId,
    this.meetingRoomId,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      student: json['student'] as String?,
      mentor: json['mentor'] is Map<String, dynamic>
          ? Mentor.fromJson(json['mentor'] as Map<String, dynamic>)
          : Mentor.fromJson({
        'id': json['mentor'] as String? ?? '',
      }),
      date: json['bookingDate'] != null
          ? DateTime.parse(json['bookingDate'] as String)
          : (json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now()),
      time: (json['timeSlot'] ?? json['time'] ?? '') as String,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      sessionType: (json['sessionType'] ?? '') as String,
      notes: (json['notes'] ?? '') as String,
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String?,
      meetingId: json['meetingId'] as String?,
      meetingRoomId: json['meetingRoomId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'student': student,
      'mentor': mentor.id, // Or pass a Map: {'id': mentor.id, 'name': mentor.name}
      'bookingDate': date.toIso8601String(),
      'timeSlot': time,
      'duration': duration,
      'sessionType': sessionType,
      'notes': notes,
      'amount': amount,
      'status': status,
      'meetingId': meetingId,
      'meetingRoomId': meetingRoomId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  BookingModel copyWith({
    String? id,
    String? student,
    Mentor? mentor,
    DateTime? date,
    String? time,
    int? duration,
    String? sessionType,
    String? notes,
    int? amount,
    String? status,
    String? meetingId,
    String? meetingRoomId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      student: student ?? this.student,
      mentor: mentor ?? this.mentor,
      date: date ?? this.date,
      time: time ?? this.time,
      duration: duration ?? this.duration,
      sessionType: sessionType ?? this.sessionType,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      meetingId: meetingId ?? this.meetingId,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}