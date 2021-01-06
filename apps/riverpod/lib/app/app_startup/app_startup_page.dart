import 'package:core/models/profile/profiles_data.dart';
import 'package:flutter/material.dart';
import 'package:core/ui/home_navigation_builder.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/app/now_playing/now_playing_page.dart';
import 'package:movie_app_demo_riverpod/app/profile_selection/profile_selection_page.dart';
import 'package:movie_app_demo_riverpod/top_level_providers.dart';

final profilesDataProvider = Provider<ProfilesData>((ref) {
  final state = ref.watch(appStartupModelProvider.state);
  return state.when(
      initializing: () => null,
      needsProfile: () => ProfilesData(),
      profileLoaded: (profilesData) => profilesData);
});

/// This is the "root" widget of the app, which sits just below MaterialApp.
/// It performs app-state initialization and returns the appropriate page.
class AppStartupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(appStartupModelProvider.state);
    return state.when(
      initializing: () => const Center(child: CircularProgressIndicator()),
      needsProfile: () => ProfileSelectionPage(),
      profileLoaded: (profileData) => HomeNavigationBuilder(
        builder: (context, tabItem) {
          if (tabItem == TabItem.nowPlaying) {
            return NowPlayingPage();
          } else {
            return ProfileSelectionPage();
          }
        },
      ),
    );
  }
}
