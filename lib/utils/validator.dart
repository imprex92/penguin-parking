enum ExpectedType { string, int, double }

bool inputValidation({input, required ExpectedType expectedType}) {
  if (input == null || input.isEmpty) {
    return false;
  } else if (expectedType == ExpectedType.int) {
    try {
      int.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  } else if (expectedType == ExpectedType.string) {
    if (input is String && int.tryParse(input) == null) {
      return true;
    } else {
      return false;
    }
  } else if (expectedType == ExpectedType.double) {
    try {
      double.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}

bool personalNumberValidation({input, required ExpectedType expectedType}) {
  if (input == null || input.isEmpty) {
    return false;
  } else {
    try {
      if (int.tryParse(input) == null || input.length != 12) {
        print(
            'Invalid personal number. It should be 12 digits long, only numbers. Please try again.');
        return false;
      } else if (input.length == 12 && is18OrOlder(input)) {
        return true;
      } else {
        print(
            'Invalid personal number. You must be 18 years or older to use this service.');
        return false;
      }
    } catch (e) {
      print('Invalid personal number. Please try again.');
      return false;
    }
  }
}

bool is18OrOlder(String personalNumber) {
  final int birthYear = int.parse(personalNumber.substring(0, 4));
  final int birthMonth = int.parse(personalNumber.substring(4, 6));
  final int birthDay = int.parse(personalNumber.substring(6, 8));

  final DateTime birthDate = DateTime(birthYear, birthMonth, birthDay);
  final DateTime currentDate = DateTime.now();
  final DateTime thresholdDate =
      DateTime(currentDate.year - 18, currentDate.month, currentDate.day);

  return birthDate.isBefore(thresholdDate) ||
      birthDate.isAtSameMomentAs(thresholdDate);
}
