import 'package:flutter/material.dart';
import '../../models/seat.dart';

class SeatTile extends StatelessWidget {
  final Seat seat;
  final VoidCallback onTap;

  const SeatTile({required this.seat, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final isBooked = seat.status == "BOOKED";
    return GestureDetector(
      onTap: isBooked ? null : onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isBooked ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('${seat.row}${seat.number}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
