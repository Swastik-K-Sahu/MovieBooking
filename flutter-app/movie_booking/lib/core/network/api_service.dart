import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/booking_request.dart';
import '../../models/seat.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api'; // Android emulator IP

  Future<String> bookSeat(BookingRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Booking request accepted!';
    } else {
      return 'Failed: ${response.body}';
    }
  }
  Future<List<Seat>> getSeatsForShow(int showId) async {
    final response = await http.get(Uri.parse('$_baseUrl/shows/$showId/seats'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Seat.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load seat data");
    }
  }

}
