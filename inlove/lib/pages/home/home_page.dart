import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inlove/pages/calendar/calendar_page.dart';
import 'package:inlove/pages/comliment/compliment_page.dart';
import 'package:inlove/pages/diary/diary.dart';
import 'package:inlove/pages/settings/settings_page.dart';

class _TabInfo {
  const _TabInfo(this.title, this.icon, this.page);

  final String title;
  final IconData icon;
  final Widget page;
}

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabInfo = [
      _TabInfo(
        'home',
        CupertinoIcons.home,
        ComplimentPage(),
      ),
      _TabInfo(
        'conv',
        CupertinoIcons.conversation_bubble,
        CardsDemo(),
      ),
      _TabInfo(
        'profile',
        CupertinoIcons.profile_circled,
        CalendarPage(),
      ),
      _TabInfo(
        'settings',
        CupertinoIcons.settings,
        SettingsPage(),
      ),
    ];

    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.textStyle,
      child: CupertinoTabScaffold(
        restorationId: 'cupertino_tab_scaffold',
        tabBar: CupertinoTabBar(
          items: [
            for (final tabInfo in _tabInfo)
              BottomNavigationBarItem(
                label: tabInfo.title,
                icon: Icon(tabInfo.icon),
              ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            restorationScopeId: 'cupertino_tab_view_$index',
            builder: (context) => _CupertinoDemoTab(
              title: _tabInfo[index].title,
              icon: _tabInfo[index].icon,
              page: _tabInfo[index].page,
            ),
            defaultTitle: _tabInfo[index].title,
          );
        },
      ),
    );
  }
}

class _CupertinoDemoTab extends StatelessWidget {
  const _CupertinoDemoTab({
    Key? key,
    required this.title,
    required this.icon,
    required this.page,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      backgroundColor: CupertinoColors.systemBackground,
      resizeToAvoidBottomInset: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 70, 0, 50),
        child: page,
      ),
    );
  }
}
