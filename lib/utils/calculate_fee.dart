import 'dart:io';
import 'package:penguin_parking/models/parking_space.dart';
import 'package:penguin_parking/utils/parkingspaceexploiter.dart';
import 'package:penguin_parking/utils/validator.dart';
import '../main.dart';

void calculateParkingFee() {
  List<ParkingSpace> allParkingSpaces =
      ParkingSpaceRepository().getAllParkingSpaces();

  if (allParkingSpaces.isEmpty) {
    print('There are no parking spaces registered in the system.');
    whatToDoNext();
  } else {
    print(
        "There are currently ${allParkingSpaces.length} ${allParkingSpaces.length == 1 ? 'parking space' : 'parking spaces'} in the system:");
    for (int i = 0; i < allParkingSpaces.length; i++) {
      print(
          '$i. ${allParkingSpaces[i].address} - Hourly price: \$${allParkingSpaces[i].hourPrice}');
    }
    print('Please enter the number of the parking space you parked at:');

    String? parkingSpaceChoice = stdin.readLineSync();
    while (!inputValidation(
        input: parkingSpaceChoice, expectedType: ExpectedType.int)) {
      print(
          'Invalid input. Please enter a number between 0 and ${allParkingSpaces.length}.');
      parkingSpaceChoice = stdin.readLineSync();
    }
    int parkingSpaceIndex = int.parse(parkingSpaceChoice!);

    print('Please enter the number of hours you parked for:');

    String? hoursParked = stdin.readLineSync();
    while (!inputValidation(
        input: hoursParked, expectedType: ExpectedType.double)) {
      print('Invalid input. Please enter a number.');
      hoursParked = stdin.readLineSync();
    }
    double totalFee = allParkingSpaces[parkingSpaceIndex].hourPrice *
        double.parse(hoursParked!);

    print('Your total fee is: \$$totalFee');

    print('Would you like to do a new calculation?');
    print('1. Yes');
    print('2. No');

    String? newCalculation = stdin.readLineSync();
    while (!inputValidation(
        input: newCalculation, expectedType: ExpectedType.int)) {
      print('Invalid input. Please enter a number between 1 and 2.');
      newCalculation = stdin.readLineSync();
    }

    if (int.parse(newCalculation!) == 1) {
      calculateParkingFee();
    } else {
      whatToDoNext();
    }
  }
}
