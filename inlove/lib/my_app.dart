import 'package:flutter/material.dart';
import 'package:inlove/pages/tabs/diary/memory/memory_page.dart';

import 'pages/authentication/authentication_page.dart';
import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthorizationPage(),
        HomePage.routeName: (context) => HomePage(),
        MemoryConstructor.routeName: (context) => MemoryConstructor(),
      },
    );
  }
}
