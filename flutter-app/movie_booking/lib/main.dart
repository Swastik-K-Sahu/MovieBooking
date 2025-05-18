import 'package:flutter/material.dart';
import 'package:movie_booking/viewmodels/booking_viewmodel.dart';
import 'package:movie_booking/views/booking_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BookingScreen(),
      ),
    ),
  );
}
