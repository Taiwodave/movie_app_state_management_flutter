import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/app/home_navigation.dart';
import 'package:tmdb_flutter_bloc_demo/app/profile_selection_page.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/app_startup/app_startup_cubit.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/app_startup/app_startup_state.dart';

/// This is the "root" widget of the app, which sits just below MaterialApp.
/// It performs app-state initialization and returns the appropriate page.
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
            child: HomeNavigation(),
          ),
        );
      },
    );
  }
}
