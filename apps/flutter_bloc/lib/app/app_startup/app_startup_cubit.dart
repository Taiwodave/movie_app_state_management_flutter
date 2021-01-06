import 'dart:async';

import 'package:core/persistence/local_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/models/app_state/app_startup_state.dart';

class AppStartupCubit extends Cubit<AppStartupState> {
  AppStartupCubit({@required this.localDB})
      : super(const AppStartupState.initializing()) {
    init();
  }
  final LocalDB localDB;
  StreamSubscription _subscription;

  void dispose() {
    _subscription?.cancel();
  }

  void init() {
    _subscription = localDB.profilesData().listen((profilesData) {
      if (profilesData.selectedId == null || profilesData.profiles.isEmpty) {
        emit(const AppStartupState.needsProfile());
      } else {
        emit(AppStartupState.profileLoaded(profilesData));
      }
    });
  }

  // @override
  // void onChange(Change<AppStartupState> change) {
  //   print(change.nextState);
  //   super.onChange(change);
  // }
}
