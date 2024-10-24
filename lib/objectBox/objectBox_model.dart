import 'package:objectbox/objectbox.dart';

@Entity()
class Human {
  @Id()
  int id = 0; // Let ObjectBox auto-generate the ID.

  String name;
  int personalNumber;

  // One-to-many relation with Broom
  @Backlink('owner') // Refers to the 'owner' field in Broom class.
  final brooms =
      ToMany<Broom>(); // Replacing List<String> with ObjectBox relation.

  Human({
    required this.name,
    required this.personalNumber,
  });

  @override
  String toString() {
    return 'Human{id: $id, name: $name, personalNumber: $personalNumber, brooms: ${brooms.map((broom) => broom.plateNumber).toList()}}';
  }
}

@Entity()
class Broom {
  @Id()
  int id = 0; // Let ObjectBox auto-generate the ID.

  String type;
  String brand;
  String model;
  String plateNumber;

  // Many-to-one relation to Human
  final owner = ToOne<Human>();

  Broom({
    required this.type,
    required this.brand,
    required this.model,
    required this.plateNumber,
  });

  @override
  String toString() {
    return 'Broom{id: $id, type: $type, brand: $brand, model: $model, plateNumber: $plateNumber, owner: ${owner.target?.name ?? 'No owner'}}';
  }
}

@Entity()
class Parking {
  @Id()
  int id = 0; // Let ObjectBox auto-generate the ID.

  // Reference to a Broom (foreign key).
  final broom = ToOne<Broom>();

  String parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking({
    required this.parkingSpace,
    DateTime? startTime,
    this.endTime,
  }) : startTime = startTime ?? DateTime.now();

  @override
  String toString() {
    return 'Parking{id: $id, broom: ${broom.target?.plateNumber}, parkingSpace: $parkingSpace, startTime: $startTime, endTime: $endTime}';
  }
}

@Entity()
class ParkingSpace {
  @Id()
  int id = 0; // Let ObjectBox auto-generate the ID.

  String address;
  double hourPrice;

  ParkingSpace({
    required this.address,
    required this.hourPrice,
  });

  @override
  String toString() {
    return 'ParkingSpace{id: $id, address: $address, hourPrice: $hourPrice}';
  }
}
