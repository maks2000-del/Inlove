import 'package:flutter/material.dart';
import 'package:inlove/injector.dart';

import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const MyApp());
}

const Map<int, Color> calendarColors = {
  0: Color.fromARGB(162, 255, 38, 0),
  1: Color.fromARGB(160, 255, 221, 0),
  2: Color.fromARGB(162, 51, 255, 0),
  3: Color.fromARGB(162, 0, 255, 242),
  4: Color.fromARGB(161, 0, 60, 255),
  5: Color.fromARGB(162, 255, 0, 179),
};
