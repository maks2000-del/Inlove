import 'package:flutter/material.dart';
import 'package:inlove/injector.dart';

import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(
    const MyApp(),
  );
}
