class Broom {
  String type;
  String brand;
  String model;
  String plateNumber;
  int owner;

  Broom({
    required this.type,
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.owner,
  });

  @override
  String toString() {
    return 'Broom{type: $type, brand: $brand, model: $model, plateNumber: $plateNumber, owner: $owner}';
  }
}
