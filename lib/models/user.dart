import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String personalNumber;
  final String age;

  User(
      {String? id,
      required this.name,
      required this.personalNumber,
      required this.age})
      : id = id ?? Uuid().v4();
}
