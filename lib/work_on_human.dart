import 'dart:io';
import 'package:penguin_parking/main.dart';
import 'package:penguin_parking/models/human.dart';
import 'package:penguin_parking/utils/humanexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';

workOnHuman() {
  print('What would you like to do with the poor humans?');
  print('1. Add a human');
  print('2. Edit a human');
  print('3. Delete a human');
  print('4. List all humans');
  print('5. Exit');

  String? humanOperation = stdin.readLineSync();

  while (
      !inputValidation(input: humanOperation, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 5.');
    humanOperation = stdin.readLineSync();
  }

  switch (int.parse(humanOperation!)) {
    case 1:
      addNewHumanLifesign();
      break;
    case 2:
      editHumanLifeSign();
      break;
    case 3:
      deleteHumanLifeSign();
      break;
    case 4:
      getAllHumans();
      whatToDoNext();
      break;
    case 5:
      whatToDoNext();
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 5.');
      workOnHuman();
  }
}

addNewHumanLifesign() async {
  print("Awesome! Let's add a new human!");
  print('Please, tell me your name:');
  String? name = stdin.readLineSync();
  while (!inputValidation(expectedType: ExpectedType.string, input: name)) {
    print('Invalid input. Please enter a valid name.');
    addNewHumanLifesign();
  }
  print(
      'Nice to meet you $name! Now please tell me your personal number. Enter it like this YYYYMMDDXXXX:');
  String? personalNumber = stdin.readLineSync();
  while (
      !inputValidation(expectedType: ExpectedType.int, input: personalNumber)) {
    print('Invalid input. Please enter a valid personal number.');
    addNewHumanLifesign();
  }

  Human newHuman =
      Human(name: name!, personalNumber: int.parse(personalNumber!));
  bool didItWork = HumanRepository().addLifesign(newHuman);
  if (didItWork) {
    print('$name - $personalNumber was added!');
    whatToDoNext();
  } else {
    addNewHumanLifesign();
  }
}

void editHumanLifeSign() {
  print("Awesome! Let's edit a human!");
  List<Human> allHumans = HumanRepository().getAllLifeSigns();
  if (allHumans.isEmpty) {
    print(
        'Unfortunately there are no humans to execute. Try adding some first.');
    whatToDoNext();
  } else {
    for (int i = 0; i < allHumans.length; i++) {
      print('$i. ${allHumans[i].name} (${allHumans[i].personalNumber})');
    }
    print('Enter the number of the human you want to edit:');
    String? humanNumber = stdin.readLineSync();
    while (
        !inputValidation(expectedType: ExpectedType.int, input: humanNumber)) {
      print('Invalid input. Please enter a valid number.');
      humanNumber = stdin.readLineSync();
    }
    if (int.parse(humanNumber!) < 0 ||
        int.parse(humanNumber!) > allHumans.length) {
      print('Invalid input. Please enter a valid number.');
      editHumanLifeSign();
    }
    Human humanToEdit = allHumans[int.parse(humanNumber)];
    Human editedHuman =
        HumanRepository().getLifeSignAndUpdate(humanToEdit.personalNumber);
    if (editedHuman != humanToEdit) {
      print('Human successfully edited!');
      whatToDoNext();
    } else {
      print("We couldn't update. Please try again.");
      editHumanLifeSign();
    }
  }
}

void deleteHumanLifeSign() {
  print("Awesome! Let's execute a human!");
  List<Human> allHumans = HumanRepository().getAllLifeSigns();

  if (allHumans.isEmpty) {
    print(
        'Unfortunately there are no humans to execute. Try adding some first.');
    whatToDoNext();
  } else {
    for (int i = 0; i < allHumans.length; i++) {
      print('$i. ${allHumans[i].name} (${allHumans[i].personalNumber})');
    }
    print('Enter the number of the human you want to delete:');
    String? humanNumber = stdin.readLineSync();
    while (
        !inputValidation(expectedType: ExpectedType.int, input: humanNumber)) {
      print('Invalid input. Please enter a valid number.');
      humanNumber = stdin.readLineSync();
    }
    if (int.parse(humanNumber!) < 0 ||
        int.parse(humanNumber!) > allHumans.length) {
      print('Invalid input. Please enter a valid number.');
      deleteHumanLifeSign();
    }
    Human humanToDelete = allHumans[int.parse(humanNumber)];
    HumanRepository().removeLifesign(humanToDelete.personalNumber);
    whatToDoNext();
  }
}

void getAllHumans() {
  List<Human> allHumans = HumanRepository().getAllLifeSigns();
  print(
      "There are currently ${allHumans.length} ${allHumans.length == 1 ? 'human' : 'humans'} in the system:");
  for (int i = 0; i < allHumans.length; i++) {
    print('${i + 1}. ${allHumans[i].name} (${allHumans[i].personalNumber})');
  }
}
