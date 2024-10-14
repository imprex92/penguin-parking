import 'dart:io';
import 'package:penguin_parking/utils/parkingspaceexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';

import 'main.dart';
import 'models/parking_space.dart';

void workOnParkingSpace() {
  print('What would you like to do with the parking spaces?');
  print('1. Add a new parking space');
  print('2. Remove a parking space');
  print('3. Update a parking space');
  print('4. List all parking spaces');
  print('5. Go back to main menu');
  print('6. Exit');

  String? parkingSpaceHandle = stdin.readLineSync();

  while (!inputValidation(
      input: parkingSpaceHandle, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 6.');
    parkingSpaceHandle = stdin.readLineSync();
  }

  switch (int.parse(parkingSpaceHandle!)) {
    case 1:
      addNewParkingSpace();
      break;
    case 2:
      removeParkingSpace();
      break;
    case 3:
      updateParkingSpace();
      break;
    case 4:
      getAllParkingSpaces();
      break;
    case 5:
      askWhatToDo();
      break;
    case 6:
      print('Goodbye!');
      exitCode = 0;
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 6.');
      workOnParkingSpace();
  }
}

void addNewParkingSpace() {
  print('Please enter the address of the new parking space:');
  String? address = stdin.readLineSync();
  while (!inputValidation(input: address, expectedType: ExpectedType.string)) {
    print('Invalid input. Please enter a valid address.');
    address = stdin.readLineSync();
  }

  print(
      'Please enter the hourly price in \$ (USD) of the new parking space ex: 10.0:');
  String? hourPrice = stdin.readLineSync();
  while (
      !inputValidation(input: hourPrice, expectedType: ExpectedType.double)) {
    print('Invalid input. Please enter a number.');
    hourPrice = stdin.readLineSync();
  }

  ParkingSpace newParkingSpace = ParkingSpace(
    address: address!,
    hourPrice: double.parse(hourPrice!),
  );
  ParkingSpaceRepository().addNewParkingSpace(newParkingSpace);

  whatToDoNext();
}

void removeParkingSpace() {
  List<ParkingSpace> allParkingSpaces =
      ParkingSpaceRepository().getAllParkingSpaces();
  if (allParkingSpaces.isEmpty) {
    print('There are no parking spaces registered in the system.');
    whatToDoNext();
    return;
  } else {
    print(
        'There are currently ${allParkingSpaces.length} ${allParkingSpaces.length == 1 ? 'parking space' : 'parking spaces'} in the system:');
    for (int i = 0; i < allParkingSpaces.length; i++) {
      print(
          '$i. ${allParkingSpaces[i].address} - Hourly price: \$${allParkingSpaces[i].hourPrice}');
    }
    print('Please enter the number of the parking space you want to remove:');

    String? parkingSpaceChoice = stdin.readLineSync();
    while (!inputValidation(
        input: parkingSpaceChoice, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allParkingSpaces.length}.');
      parkingSpaceChoice = stdin.readLineSync();
    }

    int parkingSpaceIndex = int.parse(parkingSpaceChoice!);
    ParkingSpaceRepository()
        .removeParkingSpace(allParkingSpaces[parkingSpaceIndex].id);

    whatToDoNext();
  }
}

void updateParkingSpace() {
  List<ParkingSpace> allParkingSpaces =
      ParkingSpaceRepository().getAllParkingSpaces();
  if (allParkingSpaces.isEmpty) {
    print('There are no parking spaces registered in the system.');
    whatToDoNext();
  } else {
    print(
        'There are currently ${allParkingSpaces.length} ${allParkingSpaces.length == 1 ? 'parking space' : 'parking spaces'} in the system:');
    for (int i = 0; i < allParkingSpaces.length; i++) {
      print(
          '$i. ${allParkingSpaces[i].address} - Hourly price: \$${allParkingSpaces[i].hourPrice}');
    }
    print('Please enter the number of the parking space you want to update:');

    String? parkingSpaceChoice = stdin.readLineSync();
    while (!inputValidation(
        input: parkingSpaceChoice, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allParkingSpaces.length}.');
      parkingSpaceChoice = stdin.readLineSync();
    }

    int parkingSpaceIndex = int.parse(parkingSpaceChoice!);
    ParkingSpace parkingSpace = allParkingSpaces[parkingSpaceIndex];
    ParkingSpace updatedParkingSpace =
        ParkingSpaceRepository().getParkingSpaceAndUpdate(parkingSpace.id);

    if (updatedParkingSpace != parkingSpace) {
      print('Parking space successfully updated!');
      whatToDoNext();
    } else {
      print("Something went wrong. Please try again.");
      updateParkingSpace();
    }
  }
}

void getAllParkingSpaces() {
  List<ParkingSpace> allParkingSpaces =
      ParkingSpaceRepository().getAllParkingSpaces();
  if (allParkingSpaces.isEmpty) {
    print('There are no parking spaces registered in the system.');
    whatToDoNext();
  } else {
    print(
        'There are currently ${allParkingSpaces.length} ${allParkingSpaces.length == 1 ? 'parking space' : 'parking spaces'} in the system:');
    for (int i = 0; i < allParkingSpaces.length; i++) {
      print(
          '${i + 1}. ${allParkingSpaces[i].address} - Hourly price: \$${allParkingSpaces[i].hourPrice}');
    }
    whatToDoNext();
  }
}
