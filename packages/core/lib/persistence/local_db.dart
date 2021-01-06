import 'package:core/models/profile.dart';
import 'package:core/models/profiles_data.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/*
 Profile selection
 - Show selected in profiles page (two streams?)
 - On Select, switch back to main navigation page (students asked for this)
 - Need to know at runtime what's the selected profile
 Option 1: 
 - keep "selected" flag per-profile
 - pro: easy to show if a profile is selected
 - cons: need to update all profiles when one is selected
 - hard to work out the selected one (at a snapshot)
 - could store this in Profiles class
 -> Make profiles class available to all
 */
class LocalDB {
  static DatabaseFactory dbFactory = databaseFactoryIo;

  LocalDB(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<LocalDB> init(String dbPath) async => LocalDB(
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

  Stream<ProfilesData> profiles() {
    final record = store.record('profiles');
    return record.onSnapshot(db).map((snapshot) => snapshot != null
        ? ProfilesData.fromJson(snapshot.value)
        : ProfilesData());
  }

  Future<ProfilesData> getProfiles() async {
    final profilesJson = await store.record('profiles').get(db) as String;
    return profilesJson != null
        ? ProfilesData.fromJson(profilesJson)
        : ProfilesData();
  }

  Future<bool> profileExistsWithName(String name) async {
    final profiles = await getProfiles();
    if (profiles == null) {
      return false;
    }
    final allNames =
        profiles.profiles.values.map((profile) => profile.name).toList();
    return allNames.contains(name);
  }
}
