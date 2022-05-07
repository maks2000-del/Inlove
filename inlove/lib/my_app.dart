import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/pages/tabs/diary/memory_constructor.dart';

import 'pages/authentication/authentication_page.dart';
import 'pages/home/home_page.dart';
import 'pages/tabs/calendar/special_date_constructor.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic App',
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthorizationPage(),
        HomePage.routeName: (context) => const HomePage(),
        MemoryConstructor.routeName: (context) => MemoryConstructor(),
        SpecialDateConstructor.routeName: (context) =>
            const SpecialDateConstructor(),
      },
    );
  }
}
