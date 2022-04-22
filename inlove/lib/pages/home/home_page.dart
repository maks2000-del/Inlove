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
          appBar: NeumorphicAppBar(),
          body: PageView(
            onPageChanged: (index) => _homeCubit.setTab(index),
            controller: _controller,
            children: [
              const KeepAlivePage(child: ComplimentTab()),
              const KeepAlivePage(child: DiaryTab()),
              KeepAlivePage(child: CalendarTab()),
              KeepAlivePage(child: SettingsTab()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.pageIndex,
            onTap: (int index) {
              _controller.jumpToPage(index);
              _homeCubit.setTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.star),
                label: 'Compliment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tablet),
                label: 'Diary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
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
