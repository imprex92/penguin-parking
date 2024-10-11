import 'dart:io';

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
  print(now);
}

void askWhatToDo() {
  print('What would you like to handle?');
  print('1. Persons');
  print('2. Brooms');
  print('3. Parkingspaces');
  print('4. Parkings');
  print('5. Exit');

  final String? whatHandle = stdin.readLineSync();

  switch (whatHandle) {
    case '1':
  }
}
