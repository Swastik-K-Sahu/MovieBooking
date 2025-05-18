import 'package:flutter/material.dart';
import 'package:movie_booking/views/widgets/seat_tile.dart';
import 'package:provider/provider.dart';
import '../viewmodels/booking_viewmodel.dart';

class BookingScreen extends StatelessWidget {
  final int showId = 1;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BookingViewModel>(context);
    final showId = 1;

    return Scaffold(
      appBar: AppBar(title: Text("Book Your Seat")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: viewModel.loadSeats(showId),
              builder: (context, snapshot) {
                if (viewModel.isLoading) return Center(child: CircularProgressIndicator());

                final seats = viewModel.seats;
                if (seats.isEmpty) return Text("No seats found");

                return GridView.count(
                  crossAxisCount: 6,
                  children: seats.map((seat) {
                    return SeatTile(
                      seat: seat,
                      onTap: () => viewModel.bookSeatAndPollStatus("user123", showId, seat.row + seat.number),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(viewModel.message, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

}
