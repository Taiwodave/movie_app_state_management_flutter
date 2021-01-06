import 'package:flutter/material.dart';
import 'package:tmdb_flutter_bloc_demo/app/now_playing_page.dart';
import 'package:tmdb_flutter_bloc_demo/app/profile_selection_page.dart';

enum TabItem { nowPlaying, profiles }

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  TabItem _currentTab = TabItem.nowPlaying;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(currentTab: _currentTab),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: (tab) => setState(() => _currentTab = tab),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key, this.currentTab}) : super(key: key);
  final TabItem currentTab;

  @override
  Widget build(BuildContext context) {
    if (currentTab == TabItem.nowPlaying) {
      return NowPlayingPage.create(context);
    } else {
      return ProfileSelectionPage();
    }
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {@required this.currentTab, @required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart),
          label: 'Now Playing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_railway),
          label: 'Profiles',
        ),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }
}
