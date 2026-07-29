import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';
import '../mentor_booking/meeting_lobby_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
final BookingService _bookingService = BookingService();

List<BookingModel> _bookings = [];
bool _isLoading = true;
String? _error;

@override
void initState() {
super.initState();
_loadBookings();
}

Future<void> _loadBookings() async {
setState(() {
_isLoading = true;
_error = null;
});

try {
final bookings = await _bookingService.getMyBookings();

setState(() {
_bookings = bookings;
_isLoading = false;
});
} catch (e) {
setState(() {
_error = e.toString();
_isLoading = false;
});
}
}

Color _statusColor(String status) {
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

IconData _statusIcon(String status) {
switch (status.toLowerCase()) {
case "accepted":
return Icons.check_circle;
case "pending":
return Icons.schedule;
case "rejected":
return Icons.cancel;
case "completed":
return Icons.verified;
default:
return Icons.info;
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey.shade100,

appBar: AppBar(
title: const Text("My Bookings"),
centerTitle: true,
elevation: 0,
),

body: RefreshIndicator(
onRefresh: _loadBookings,
child: _buildBody(),
),
);
}

Widget _buildBody() {
if (_isLoading) {
return const Center(
child: CircularProgressIndicator(),
);
}

if (_error != null) {
return Center(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.error_outline,
size: 70, color: Colors.red),

const SizedBox(height: 16),

Text(
_error!,
textAlign: TextAlign.center,
),

const SizedBox(height: 20),

ElevatedButton(
onPressed: _loadBookings,
child: const Text("Retry"),
),
],
),
),
);
}

if (_bookings.isEmpty) {
return const Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.calendar_month,
size: 90, color: Colors.grey),

SizedBox(height: 20),

Text(
"No bookings yet",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
],
),
);
}

return ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: _bookings.length,
itemBuilder: (context, index) {
final booking = _bookings[index];
return Card(
  elevation: 3,
  margin: const EdgeInsets.only(bottom: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            const CircleAvatar(
              radius: 28,
              child: Icon(Icons.person),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    booking.mentor.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    booking.mentor.company,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _statusColor(booking.status ?? '')
                    .withOpacity(.15),
                borderRadius:
                BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(
                    _statusIcon(booking.status ?? ''),
                    color: _statusColor(booking.status ?? ''),
                    size: 18,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    booking.status ?? '',
                    style: TextStyle(
                      color:
                      _statusColor(booking.status ?? ''),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [

            const Icon(Icons.calendar_today,
                size: 18),

            const SizedBox(width: 8),

            Expanded(
              child: Text(booking.date.toString()),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [

            const Icon(Icons.access_time,
                size: 18),

            const SizedBox(width: 8),

            Expanded(
              child: Text(booking.time),
            ),
          ],
        ),

        const SizedBox(height: 18),

        if ((booking.status ?? '').toLowerCase() ==
            "accepted")
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon:
              const Icon(Icons.video_call),
              label:
              const Text("Join Meeting"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        MeetingLobbyScreen(
                          booking: booking,
                        ),
                  ),
                );
              },
            ),
          ),

        if ((booking.status ?? '').toLowerCase() ==
            "pending")
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: null,
              icon:
              const Icon(Icons.schedule),
              label: const Text(
                  "Waiting for mentor approval"),
            ),
          ),

        if ((booking.status ?? '').toLowerCase() ==
            "completed")
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                  Icons.check_circle),
              label:
              const Text("Session Completed"),
            ),
          ),

        if ((booking.status ?? '').toLowerCase() ==
            "rejected")
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.cancel),
              label:
              const Text("Booking Rejected"),
            ),
          ),
      ],
    ),
  ),
);
},
);
}
}