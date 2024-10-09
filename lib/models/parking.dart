class Parking {
  final String broom;
  final String parkingSpace;
  final String startTime;
  final String? endTime;

  Parking({
    required this.broom,
    required this.parkingSpace,
    required this.startTime,
    this.endTime,
  });
}
