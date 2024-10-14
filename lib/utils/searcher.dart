import 'dart:io';
import 'package:penguin_parking/main.dart';
import 'package:penguin_parking/utils/humanexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';
import '../models/human.dart';

findBroomsByOwner() {
  List<Human> allHumans = HumanRepository().getAllLifeSigns();
  if (allHumans.isEmpty) {
    print('There are no humans registered in the system.');
    askWhatToDo();
  }
  print(
      'There are currently ${allHumans.length} ${allHumans.length > 1 ? 'humans' : 'human'} in the system');
  for (int i = 0; i < allHumans.length; i++) {
    print('$i. ${allHumans[i].name} (${allHumans[i].personalNumber})');
  }

  print('Please select the human whose brooms you want to see:');

  String? personalNumber = stdin.readLineSync();
  while (
      !inputValidation(input: personalNumber, expectedType: ExpectedType.int)) {
    print(
        'Invalid input. Please enter a number between 0 and ${allHumans.length}.');
    personalNumber = stdin.readLineSync();
  }

  Human? selectedHuman = allHumans[int.parse(personalNumber!)];
  List<dynamic> broomsOwnedByHuman = selectedHuman.broomList;

  if (broomsOwnedByHuman.isEmpty) {
    print('This human does not own any brooms.');
  } else {
    print(
        'This human owns ${broomsOwnedByHuman.length} ${broomsOwnedByHuman.length > 1 ? 'brooms' : 'broom'}:');
    for (int i = 0; i < broomsOwnedByHuman.length; i++) {
      print('${i + 1}. Licence plate - ${broomsOwnedByHuman[i]}');
    }
  }
  whatToDoNext();
}
