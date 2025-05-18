import 'package:flutter/material.dart';
import '../core/network/api_service.dart';
import '../models/booking_request.dart';
import '../models/seat.dart';

class BookingViewModel extends ChangeNotifier {
  List<Seat> seats = [];
  final ApiService _apiService = ApiService();
  String message = '';
  bool isLoading = false;

  Future<void> bookSeat(String userId, int showId, String seatNumber) async {
    isLoading = true;
    notifyListeners();

    BookingRequest request = BookingRequest(userId: userId, showId: showId, seatNumber: seatNumber);
    message = await _apiService.bookSeat(request);

    isLoading = false;
    notifyListeners();
  }
  Future<void> loadSeats(int showId) async {
    seats = await _apiService.getSeatsForShow(showId);
    notifyListeners();
  }

  Future<void> bookSeatAndPollStatus(String userId, int showId, String seatNumber) async {
    isLoading = true;
    notifyListeners();

    final request = BookingRequest(userId: userId, showId: showId, seatNumber: seatNumber);
    final res = await _apiService.bookSeat(request);
    message = res;

    // Polling logic
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 2));
      final updatedSeats = await _apiService.getSeatsForShow(showId);
      seats = updatedSeats;
      notifyListeners();

      final selected = updatedSeats.firstWhere((s) => s.row + s.number == seatNumber);
      if (selected.status == "BOOKED") {
        message = "Seat confirmed!";
        break;
      }
    }

    isLoading = false;
    notifyListeners();
  }
}




