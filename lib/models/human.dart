class Human {
  String name;
  int personalNumber;
  List<String> broomList;

  Human({
    required this.name,
    required this.personalNumber,
    List<String>? broomList,
  }) : broomList = broomList ?? [];

  bool isValid() {
    // Implement validation logic here maybe?
    return name.isNotEmpty && personalNumber > 0;
  }

  @override
  String toString() {
    return 'Human{name: $name, personalNumber: $personalNumber, broomList: $broomList}';
  }
}
