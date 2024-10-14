import 'dart:io';
import 'package:penguin_parking/utils/broomexploiter.dart';
import 'package:penguin_parking/utils/calculate_fee.dart';
import 'package:penguin_parking/utils/humanexploiter.dart';
import 'package:penguin_parking/utils/searcher.dart';
import 'package:penguin_parking/utils/validator.dart';
import 'package:penguin_parking/work_on_broom.dart';
import 'package:penguin_parking/work_on_human.dart';
import 'package:penguin_parking/work_on_parking.dart';
import 'package:penguin_parking/work_on_parking_space.dart';

void getGreeting() {
  final DateTime now = DateTime.now();
  final String welcomeMessage = 'Welcome to Penguin Parking!';

  if (now.hour < 12) {
    print('Good morning! $welcomeMessage');
  } else if (now.hour < 18) {
    print('Good afternoon! $welcomeMessage');
  } else {
    print('Good evening! $welcomeMessage');
  }
}

void askWhatToDo() {
  print('What would you like to handle?');
  print('1. Human');
  print('2. Brooms');
  print('3. Parkingspaces');
  print('4. Parkings');
  print('5. Search for brooms by specific owner');
  print('6. I want to calculate parking fee');
  print("7. I'm lazy and want to apply mock data");
  print('8. Exit');

  String? whatHandle = stdin.readLineSync();

  while (!inputValidation(input: whatHandle, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 8.');
    whatHandle = stdin.readLineSync();
  }

  switch (int.parse(whatHandle!)) {
    case 1:
      workOnHuman();
      break;
    case 2:
      workOnBroom();
      break;
    case 3:
      workOnParkingSpace();
      break;
    case 4:
      workOnParking();
      break;
    case 5:
      findBroomsByOwner();
      break;
    case 6:
      calculateParkingFee();
      break;
    case 7:
      applyMockData();
    case 8:
      print('Goodbye!');
      exitCode = 0;
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 6.');
      askWhatToDo();
  }
}

void whatToDoNext() {
  print('What would you like to do next?');
  print('1. Go back to main menu');
  print('2. Exit');

  String? nextChoice = stdin.readLineSync();

  while (!inputValidation(input: nextChoice, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 2.');
    nextChoice = stdin.readLineSync();
  }

  switch (int.parse(nextChoice!)) {
    case 1:
      askWhatToDo();
      break;
    case 2:
      print('Goodbye!');
      exitCode = 0;
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 2.');
      whatToDoNext();
  }
}

void applyMockData() {
  print(
      'Would you like to apply mock data? This will overwrite existing data.');
  print('1. Yes');
  print('2. No');

  String? applyMockData = stdin.readLineSync();

  while (
      !inputValidation(input: applyMockData, expectedType: ExpectedType.int)) {
    print('Invalid input. Please enter a number between 1 and 2.');
    applyMockData = stdin.readLineSync();
  }

  switch (int.parse(applyMockData!)) {
    case 1:
      HumanRepository().applyMockData();
      BroomRepository().applyMockData();
      whatToDoNext();
      break;
    case 2:
      print('No mock data applied.');
      whatToDoNext();
      break;
    default:
      print('Invalid input. Please enter a number between 1 and 2.');
      askWhatToDo();
  }
}
