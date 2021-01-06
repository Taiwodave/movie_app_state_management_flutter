import 'dart:async';

import 'package:core/persistence/local_db.dart';
import 'package:flutter/foundation.dart';
import 'package:core/models/app_state/app_startup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStartupModel extends StateNotifier<AppStartupState> {
  AppStartupModel({@required this.localDB})
      : super(const AppStartupState.initializing()) {
    init();
  }
  final LocalDB localDB;
  StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void init() {
    _subscription = localDB.profilesData().listen((profilesData) {
      if (profilesData.selectedId == null || profilesData.profiles.isEmpty) {
        state = AppStartupState.needsProfile();
      } else {
        state = AppStartupState.profileLoaded(profilesData);
      }
    });
  }
}
