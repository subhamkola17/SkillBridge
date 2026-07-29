import 'package:flutter/material.dart';

import '../../services/booking_service.dart';

class MentorBookingsScreen extends StatefulWidget {
  const MentorBookingsScreen({super.key});

  @override
  State<MentorBookingsScreen> createState() =>
      _MentorBookingsScreenState();
}

class _MentorBookingsScreenState
    extends State<MentorBookingsScreen> {
  final BookingService _bookingService = BookingService();

  List<dynamic> bookings = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    setState(() {
      loading = true;
    });

    try {
      bookings = await _bookingService.getMentorBookings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> acceptBooking(String id) async {
    await _bookingService.acceptBooking(id);
    loadBookings();
  }

  Future<void> rejectBooking(String id) async {
    await _bookingService.rejectBooking(id);
    loadBookings();
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return Colors.green;

      case "pending":
        return Colors.orange;

      case "rejected":
        return Colors.red;

      case "completed":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Requests"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : bookings.isEmpty
          ? const Center(
        child: Text(
          "No booking requests",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];

          return Card(
            margin:
            const EdgeInsets.only(bottom: 16),
            elevation: 3,
            child: Padding(
              padding:
              const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    booking["student"]["name"],
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    booking["student"]["email"],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Date : ${booking["bookingDate"]}",
                  ),

                  Text(
                    "Time : ${booking["timeSlot"]}",
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor(
                        booking["status"],
                      ).withOpacity(.15),
                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),
                    child: Text(
                      booking["status"],
                      style: TextStyle(
                        color: statusColor(
                          booking["status"],
                        ),
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (booking["status"] ==
                      "Pending")
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              acceptBooking(
                                  booking["_id"]);
                            },
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              Colors.green,
                            ),
                            child: const Text(
                                "Accept"),
                          ),
                        ),

                        const SizedBox(
                            width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              rejectBooking(
                                  booking["_id"]);
                            },
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              Colors.red,
                            ),
                            child: const Text(
                                "Reject"),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}