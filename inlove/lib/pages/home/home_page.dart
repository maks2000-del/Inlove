import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/pages/home/home_cubit.dart';
import 'package:inlove/pages/tabs/calendar/calendar_tab.dart';
import 'package:inlove/pages/tabs/comliment/compliment_tab.dart';
import 'package:inlove/pages/tabs/diary/diary_tab.dart';
import 'package:inlove/pages/tabs/settings/settings_tab.dart';

import '../../helpers/keep_alive_page.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit _homeCubit = HomeCubit();
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            onPageChanged: (index) => _homeCubit.setTab(index),
            controller: _controller,
            children: const [
              KeepAlivePage(child: ComplimentTab()),
              KeepAlivePage(child: DiaryTab()),
              KeepAlivePage(child: CalendarTab()),
              KeepAlivePage(child: SettingsTab()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.tabIndex,
            onTap: (int index) {
              _controller.jumpToPage(index);
              _homeCubit.setTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 37, 37, 37),
                icon: Icon(
                  Icons.emoji_emotions,
                  color: Colors.orange,
                ),
                label: 'Compliment',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 37, 37, 37),
                icon: Icon(
                  Icons.book,
                  color: Colors.orange,
                ),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 37, 37, 37),
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.orange,
                ),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 37, 37, 37),
                icon: Icon(
                  Icons.settings,
                  color: Colors.orange,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
