import 'package:core/models/profile.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

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
      final profiles = Profiles.fromJson(profilesJson);
      profiles.values[profile.id] = profile;
      await store.record('profiles').put(db, profiles.toJson());
    } else {
      final profiles = Profiles(values: {profile.id: profile});
      await store.record('profiles').put(db, profiles.toJson());
    }
  }

  Stream<Profiles> profiles() {
    final record = store.record('profiles');
    return record.onSnapshot(db).map((snapshot) =>
        snapshot != null ? Profiles.fromJson(snapshot.value) : null);
  }

  Future<Profiles> getProfiles() async {
    final profilesJson = await store.record('profiles').get(db) as String;
    return profilesJson != null ? Profiles.fromJson(profilesJson) : null;
  }

  Future<Profile> getProfile(String profileId) async {
    final profileEncoded =
        await store.record('profile/$profileId').get(db) as String;
    return Profile.fromJson(profileEncoded);
  }

  Future<bool> profileExistsWithName(String name) async {
    final profiles = await getProfiles();
    if (profiles == null) {
      return false;
    }
    final allNames =
        profiles.values.values.map((profile) => profile.name).toList();
    return allNames.contains(name);
  }
}
