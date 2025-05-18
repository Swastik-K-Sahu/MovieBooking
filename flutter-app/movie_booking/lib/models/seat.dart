class Seat {
  final String row;
  final String number;
  final String status;

  Seat({required this.row, required this.number, required this.status});

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    row: json['row'],
    number: json['number'],
    status: json['status'],
  );
}
