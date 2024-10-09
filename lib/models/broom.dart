class Broom {
  final String type;
  final String brand;
  final String model;
  final String? color;
  final String plateNumber;
  final String owner;

  Broom({
    required this.type,
    required this.brand,
    required this.model,
    this.color,
    required this.plateNumber,
    required this.owner,
  });
}
