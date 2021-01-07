import '../models/profile/profile.dart';
import '../models/profile/profiles_data.dart';

/// Domain-specific data store interface
abstract class DataStore {
  Future<void> createProfile(Profile profile);
  Future<void> setSelectedProfile(Profile profile);
  Stream<ProfilesData> profilesData();
  Future<ProfilesData> getProfilesData();
  Future<bool> profileExistsWithName(String name);
}
