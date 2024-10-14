import 'dart:io';
import 'package:collection/collection.dart';
import 'package:penguin_parking/main.dart';
import 'package:penguin_parking/models/broom.dart';
import 'package:penguin_parking/models/human.dart';
import 'package:penguin_parking/utils/humanexploiter.dart';
import 'package:penguin_parking/utils/broomexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';

workOnBroom() {
  print('What would you like to do with the brooms?');
  print('1. Add a broom');
  print('2. Edit a broom');
  print('3. Delete a broom');
  print('4. List all brooms');
  print('5. Exit');

  String? broomOperation = stdin.readLineSync();

  while (
      !inputValidation(input: broomOperation, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 5.');
    broomOperation = stdin.readLineSync();
  }

  switch (int.parse(broomOperation!)) {
    case 1:
      addNewBroom();
      break;
    case 2:
      editBroom();
      break;
    case 3:
      deleteBroom();
      break;
    case 4:
      getAllBrooms();
      break;
    case 5:
      whatToDoNext();
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 5.');
      workOnBroom();
  }
}

void getAllBrooms() {
  List<Broom> allBrooms = BroomRepository().getAllBrooms();
  if (allBrooms.isEmpty) {
    print('There are no brooms registered in the system.');
    whatToDoNext();
  } else {
    print(
        "There are currently ${allBrooms.length} ${allBrooms.length == 1 ? 'human' : 'humans'} in the system:");
    for (int i = 0; i < allBrooms.length; i++) {
      print(
          '${i + 1}. ${allBrooms[i].brand} (${allBrooms[i].plateNumber}) - Owner: ${allBrooms[i].owner}');
    }
    whatToDoNext();
  }
}

void addNewBroom() {
  if (HumanRepository().lifeSigns.isEmpty) {
    print(
        'There are no humans registered in the system. Please add a human first, then you can add a broom.');
    askWhatToDo();
  }

  print("Awesome! Let's add a new broom!");

  print('Please, tell me the broom type:');

  String? type = stdin.readLineSync();
  while (!inputValidation(expectedType: ExpectedType.string, input: type)) {
    print('Invalid input. Please enter a valid type.');
    type = stdin.readLineSync();
  }

  print('Please, tell me the broom license plate number:');

  String? plateNumber = stdin.readLineSync();
  while (
      !inputValidation(expectedType: ExpectedType.string, input: plateNumber)) {
    print('Invalid input. Please enter a valid license plate number.');
    plateNumber = stdin.readLineSync();
  }

  print('Please, tell me the broom brand:');

  String? brand = stdin.readLineSync();
  while (!inputValidation(expectedType: ExpectedType.string, input: brand)) {
    print('Invalid input. Please enter a valid brand.');
    brand = stdin.readLineSync();
  }

  print('Please, tell me the broom model:');

  String? model = stdin.readLineSync();
  while (!inputValidation(expectedType: ExpectedType.string, input: model)) {
    print('Invalid input. Please enter a valid model.');
    model = stdin.readLineSync();
  }

  print('Thanks!');
  print(
      "The Broom needs to be registered to a human. Please enter the number of the human you want to register the broom to:");

  List<Human> allHumans = HumanRepository().getAllLifeSigns();
  print(
      "There are currently ${allHumans.length} ${allHumans.length == 1 ? 'human' : 'humans'} in the system:");
  for (int i = 0; i < allHumans.length; i++) {
    print('$i. ${allHumans[i].name} (${allHumans[i].personalNumber})');
  }

  String? humanNumber = stdin.readLineSync();
  while (!inputValidation(expectedType: ExpectedType.int, input: humanNumber)) {
    print('Invalid input. Please enter a valid number.');
    humanNumber = stdin.readLineSync();
  }

  int? humanToAttachTo = allHumans[int.parse(humanNumber!)].personalNumber;
  Broom newBroom = Broom(
      type: type!,
      plateNumber: plateNumber!,
      model: model!,
      brand: brand!,
      owner: humanToAttachTo);

  List<Broom> existingBrooms = BroomRepository().getAllBrooms();
  Broom? exists = existingBrooms
      .singleWhereOrNull((broom) => broom.plateNumber == newBroom.plateNumber);
  if (exists != null) {
    print(
        'This broom is already registered in the system. There cannot be multiple with same plate number.');
    addNewBroom();
  }

  registerOnHumanAndSave(newBroom, humanToAttachTo);
}

void editBroom() {
  List<Broom> allBrooms = BroomRepository().getAllBrooms();
  if (allBrooms.isEmpty) {
    print('There are no brooms registered in the system.');
    whatToDoNext();
  } else {
    print(
        "There are currently ${allBrooms.length} ${allBrooms.length == 1 ? 'broom' : 'brooms'} in the system:");
    for (int i = 0; i < allBrooms.length; i++) {
      print(
          '$i. ${allBrooms[i].brand} (${allBrooms[i].plateNumber}) - Owner: ${allBrooms[i].owner}');
    }
    print('Enter the number of the broom you want to edit:');
    String? broomNumber = stdin.readLineSync();
    while (
        !inputValidation(expectedType: ExpectedType.int, input: broomNumber)) {
      print('Invalid input. Please enter a valid number.');
      broomNumber = stdin.readLineSync();
    }
    if (int.parse(broomNumber!) < 0 ||
        int.parse(broomNumber!) > allBrooms.length) {
      print('Invalid input. Please enter a valid number.');
      editBroom();
    }
    Broom broomToEdit = allBrooms[int.parse(broomNumber)];
    Broom editedBroom =
        BroomRepository().getBroomAndUpdate(broomToEdit.plateNumber);
    if (editedBroom != broomToEdit) {
      print('Broom successfully edited!');
      whatToDoNext();
    } else {
      print("We couldn't update. Please try again.");
      editBroom();
    }
  }
}

void deleteBroom() {
  print('Lets delete a broom!');
  List<Broom> allBrooms = BroomRepository().getAllBrooms();
  if (allBrooms.isEmpty) {
    print('There are no brooms registered in the system.');
    whatToDoNext();
  } else {
    print(
        "There are currently ${allBrooms.length} ${allBrooms.length == 1 ? 'broom' : 'brooms'} in the system:");
    for (int i = 0; i < allBrooms.length; i++) {
      print(
          '$i. ${allBrooms[i].brand} (${allBrooms[i].plateNumber}) - Owner: ${allBrooms[i].owner}');
    }
    print('Enter the number of the broom you want to delete:');
    String? broomNumber = stdin.readLineSync();
    while (
        !inputValidation(expectedType: ExpectedType.int, input: broomNumber)) {
      print('Invalid input. Please enter a valid number.');
      broomNumber = stdin.readLineSync();
    }
    if (int.parse(broomNumber!) < 0 ||
        int.parse(broomNumber!) > allBrooms.length) {
      print('Invalid input. Please enter a valid number.');
      deleteBroom();
    }
    Broom broomToDelete = allBrooms[int.parse(broomNumber)];
    BroomRepository().removeBroom(broomToDelete.plateNumber);
    whatToDoNext();
  }
}

registerOnHumanAndSave(Broom newBroom, int personalNumber) {
  bool didItWork = BroomRepository().addBroom(newBroom);
  if (didItWork) {
    Human? updated = HumanRepository()
        .registerOneBroomToLifeSign(personalNumber, newBroom.plateNumber);
    bool completed = updated.broomList.singleWhereOrNull(
            (plateNumber) => plateNumber == newBroom.plateNumber) !=
        null;
    return completed
        ? whatToDoNext()
        : {print('Something went wrong. Please try again.'), addNewBroom()};
  }
  return false;
}
