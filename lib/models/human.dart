import 'package:uuid/uuid.dart';

class Human {
  List broomList;
  String id;
  String name;
  int personalNumber;

  Human(
      {String? id,
      required this.name,
      required this.personalNumber,
      List? broomList})
      : id = id ?? Uuid().v4(),
        broomList = broomList ?? [];

  @override
  String toString() {
    return 'Human{id: $id, name: $name, personalNumber: $personalNumber, broomList: $broomList}';
  }
}
