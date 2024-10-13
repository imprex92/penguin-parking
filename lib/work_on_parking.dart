import 'dart:io';
import 'package:penguin_parking/models/human.dart';
import 'package:penguin_parking/models/parking.dart';
import 'package:penguin_parking/models/parking_space.dart';
import 'package:penguin_parking/utils/humanexploiter.dart';
import 'package:penguin_parking/utils/parkingexploiter.dart';
import 'package:penguin_parking/utils/parkingspaceexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';
import 'main.dart';

workOnParking() {
  print('What would you like to do with parking?');
  print('1. Add and start new parking');
  print('2. Finish an ongoing parking');
  print('3. List all parkings');
  print('4. Go back to main menu');

  String? parkingOperation = stdin.readLineSync();

  while (!inputValidation(
      input: parkingOperation, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 4.');
    parkingOperation = stdin.readLineSync();
  }

  switch (int.parse(parkingOperation!)) {
    case 1:
      startNewParking();
      break;
    case 2:
      finishParking();
      break;
    case 3:
      getAllParkings();
      break;
    case 4:
      askWhatToDo();
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 4.');
      workOnParking();
  }
}

void startNewParking() {
  String broomToPark;
  List<Human> allHumans = HumanRepository().getAllLifeSigns();
  List<ParkingSpace> allParkingSpaces =
      ParkingSpaceRepository().getAllParkingSpaces();
  if (allHumans.isEmpty) {
    print(
        'There are no humans registered in the system. In order to start a parking, you need to add a human first.');
    whatToDoNext();
  } else if (allParkingSpaces.isEmpty) {
    print(
        'There are no parking spaces registered in the system. In order to start a parking, you need to add a parking space first.');
    whatToDoNext();
  } else {
    print('Please select the human who is starting the parking:');
    for (int i = 0; i < allHumans.length; i++) {
      print('$i. ${allHumans[i].name} (${allHumans[i].personalNumber})');
    }
    String? selectedHuman = stdin.readLineSync();
    while (!inputValidation(
        input: selectedHuman, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allHumans.length}.');
      selectedHuman = stdin.readLineSync();
    }
    Human? humanToPark = allHumans[int.parse(selectedHuman!)];
    if (humanToPark.broomList.length > 1) {
      print(
          'The human has more than one broom. Please select the broom to park:');
      for (int i = 0; i < humanToPark.broomList.length; i++) {
        print(
            '$i. ${humanToPark.broomList[i].brand} (${humanToPark.broomList[i].plateNumber})');
      }
      String? selectedBroom = stdin.readLineSync();
      while (!inputValidation(
          input: selectedBroom, expectedType: ExpectedType.int)) {
        print(
            'Invalid input. Please enter a number between 0 and ${humanToPark.broomList.length}.');
        selectedBroom = stdin.readLineSync();
      }
      broomToPark = humanToPark.broomList[int.parse(selectedBroom!)];
    } else {
      broomToPark = humanToPark.broomList[0];
    }

    print(
        'Please select the parking space where the parking is going to start:');
    for (int i = 0; i < allParkingSpaces.length; i++) {
      print(
          '$i. ${allParkingSpaces[i].address} - Hourly price: \$${allParkingSpaces[i].hourPrice}');
    }
    String? selectedParkingSpace = stdin.readLineSync();
    while (!inputValidation(
        input: selectedParkingSpace, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allParkingSpaces.length}.');
      selectedParkingSpace = stdin.readLineSync();
    }
    ParkingSpace? atParkingSpace =
        allParkingSpaces[int.parse(selectedParkingSpace!)];

    Parking newParking =
        Parking(broom: broomToPark, parkingSpace: atParkingSpace.id);
    ParkingRepository().addAndStartParking(newParking);
  }
}

void finishParking() {
  List<Parking> allParkings = ParkingRepository().getAllActiveParkings();
  if (allParkings.isEmpty) {
    print('There are currently on active parkings registered in the system.');
    whatToDoNext();
  } else {
    print('Please select the parking you want to finish:');
    for (int i = 0; i < allParkings.length; i++) {
      print('$i. ${allParkings[i].broom} - ${allParkings[i].parkingSpace}');
    }
    String? selectedParking = stdin.readLineSync();
    while (!inputValidation(
        input: selectedParking, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allParkings.length}.');
      selectedParking = stdin.readLineSync();
    }
    Parking? parkingToFinish = allParkings[int.parse(selectedParking!)];
    double feeToPay = ParkingRepository()
        .removeParkingOccupantAndFinishParking(parkingToFinish.broom);
    print('The parking has been finished. The fee to pay is: \$$feeToPay');
  }
}

void getAllParkings() {
  List<Parking> allParkings = ParkingRepository().getAllActiveParkings();
  if (allParkings.isEmpty) {
    print('There are no active parkings registered in the system.');
    whatToDoNext();
  } else {
    print(
        'There are currently ${allParkings.length} ${allParkings.length == 1 ? 'parking' : 'parkings'} in the system:');
    for (int i = 0; i < allParkings.length; i++) {
      print('$i. ${allParkings[i].broom} - ${allParkings[i].parkingSpace}');
    }
    whatToDoNext();
  }
}
