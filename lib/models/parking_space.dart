import 'package:uuid/uuid.dart';

class ParkingSpace {
  String id;
  String address;
  double hourPrice;

  ParkingSpace({
    String? id,
    required this.address,
    required this.hourPrice,
  }) : id = id ?? Uuid().v4();

  @override
  String toString() {
    return 'Parkingspace{id: $id, address: $address, hourPrice: $hourPrice}';
  }
}
