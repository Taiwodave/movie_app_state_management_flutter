import 'package:core/models/profile/profiles_data.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/app/app_startup/app_startup_model.dart';

final localDBProvider = Provider<LocalDB>((ref) => throw UnimplementedError());

final appStartupModelProvider = StateNotifierProvider<AppStartupModel>((ref) {
  final localDB = ref.watch(localDBProvider);
  return AppStartupModel(localDB: localDB);
});

final profilesDataProvider = Provider<ProfilesData>((ref) {
  final state = ref.watch(appStartupModelProvider.state);
  return state.when(
      initializing: () => null,
      needsProfile: () => ProfilesData(),
      profileLoaded: (profilesData) => profilesData);
});
