import 'package:json_annotation/json_annotation.dart';

part 'booking_request.g.dart';

@JsonSerializable()
class BookingRequest {
  final String userId;
  final int showId;
  final String seatNumber;

  BookingRequest({required this.userId, required this.showId, required this.seatNumber});

  factory BookingRequest.fromJson(Map<String, dynamic> json) => _$BookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BookingRequestToJson(this);
}
