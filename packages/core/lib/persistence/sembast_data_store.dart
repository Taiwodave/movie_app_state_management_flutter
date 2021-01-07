import 'package:core/models/profile/profile.dart';
import 'package:core/models/profile/profiles_data.dart';
import 'package:core/persistence/data_store.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Data store implementation using Sembast (local NoSQL database)
class SembastDataStore implements DataStore {
  static DatabaseFactory dbFactory = databaseFactoryIo;

  SembastDataStore(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<SembastDataStore> init(String dbPath) async => SembastDataStore(
        // We use the database factory to open the database
        await dbFactory.openDatabase(dbPath),
      );

  Future<void> createProfile(Profile profile) async {
    final profilesJson = await store.record('profiles').get(db) as String;
    if (profilesJson != null) {
      final profilesData = ProfilesData.fromJson(profilesJson);
      profilesData.profiles[profile.id] = profile;
      final newProfiles = profilesData.copyWith(selectedId: profile.id);
      await store.record('profiles').put(db, newProfiles.toJson());
    } else {
      final profilesData =
          ProfilesData(profiles: {profile.id: profile}, selectedId: profile.id);
      await store.record('profiles').put(db, profilesData.toJson());
    }
  }

  Future<void> setSelectedProfile(Profile profile) async {
    final profilesJson = await store.record('profiles').get(db) as String;
    if (profilesJson != null) {
      final profilesData = ProfilesData.fromJson(profilesJson);
      if (profilesData.profiles[profile.id] != null) {
        final newProfiles = profilesData.copyWith(selectedId: profile.id);
        await store.record('profiles').put(db, newProfiles.toJson());
        return;
      }
    }
    throw StateError('Profile $profile does not exist and can\'t be selected');
  }

  Stream<ProfilesData> profilesData() {
    final record = store.record('profiles');
    return record.onSnapshot(db).map((snapshot) => snapshot != null
        ? ProfilesData.fromJson(snapshot.value)
        : ProfilesData());
  }

  Future<ProfilesData> getProfilesData() async {
    final profilesJson = await store.record('profiles').get(db) as String;
    return profilesJson != null
        ? ProfilesData.fromJson(profilesJson)
        : ProfilesData();
  }

  Future<bool> profileExistsWithName(String name) async {
    final profiles = await getProfilesData();
    if (profiles == null) {
      return false;
    }
    final allNames =
        profiles.profiles.values.map((profile) => profile.name).toList();
    return allNames.contains(name);
  }
}
