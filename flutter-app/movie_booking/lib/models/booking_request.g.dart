// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRequest _$BookingRequestFromJson(Map<String, dynamic> json) =>
    BookingRequest(
      userId: json['userId'] as String,
      showId: (json['showId'] as num).toInt(),
      seatNumber: json['seatNumber'] as String,
    );

Map<String, dynamic> _$BookingRequestToJson(BookingRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'showId': instance.showId,
      'seatNumber': instance.seatNumber,
    };
