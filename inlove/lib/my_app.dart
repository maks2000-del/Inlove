import 'package:flutter/material.dart';
import 'package:inlove/pages/authorization/authorization_page.dart';

import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthorizationPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
