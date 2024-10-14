class Parking {
  String broom;
  String parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking({
    required this.broom,
    required this.parkingSpace,
    DateTime? startTime,
    this.endTime,
  }) : startTime = startTime ?? DateTime.now();

  @override
  String toString() {
    return 'Parking{broom: $broom, parkingSpace: $parkingSpace, startTime: $startTime, endTime: $endTime}';
  }
}
