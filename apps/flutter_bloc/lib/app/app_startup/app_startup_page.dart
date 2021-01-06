import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/ui/home_navigation_builder.dart';
import 'package:movie_app_demo_flutter_bloc/app/app_startup/app_startup_cubit.dart';
import 'package:movie_app_demo_flutter_bloc/app/now_playing/now_playing_page.dart';
import 'package:movie_app_demo_flutter_bloc/app/profile_selection/profile_selection_page.dart';
import 'package:core/models/app_state/app_startup_state.dart';

/// This is the "root" widget of the app, which sits just below MaterialApp.
/// It performs app-state initialization and returns the appropriate page.
// TODO: Implement with other state management techniques
class AppStartupPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final localDB = RepositoryProvider.of<LocalDB>(context);
    return BlocProvider<AppStartupCubit>(
      create: (_) => AppStartupCubit(localDB: localDB),
      child: AppStartupPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStartupCubit, AppStartupState>(
      builder: (_, state) {
        return state.when(
          initializing: () => const Center(child: CircularProgressIndicator()),
          needsProfile: () => ProfileSelectionPage(),
          profileLoaded: (profileData) => RepositoryProvider.value(
            value: profileData,
            child: HomeNavigationBuilder(
              builder: (context, tabItem) {
                if (tabItem == TabItem.nowPlaying) {
                  return NowPlayingPage.create(context);
                } else {
                  return ProfileSelectionPage();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
