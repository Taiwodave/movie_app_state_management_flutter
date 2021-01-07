import 'package:core/models/app_models/favourite_movies.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/app_models/profile.dart';
import '../models/app_models/profiles_data.dart';
import '../models/app_models/movies_data.dart';
import '../models/tmdb/tmdb_movie_basic.dart';
import 'data_store.dart';

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

  /// Profile methods

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

  /// Movies methods

  Future<void> storeMovie(TMDBMovieBasic movie) async {
    final moviesJson = await store.record('movies').get(db) as String;
    if (moviesJson != null) {
      final moviesData = MoviesData.fromJson(moviesJson);
      // only save movie to store if it hasn't been saved before
      if (moviesData.movies[movie.id] == null) {
        moviesData.movies[movie.id] = movie;
        await store.record('profiles').put(db, moviesData.toJson());
      }
    } else {
      final moviesData = MoviesData(movies: {movie.id: movie});
      await store.record('profiles').put(db, moviesData.toJson());
    }
  }

  Future<void> addFavouriteMovie(
      {@required Profile profile, @required TMDBMovieBasic movie}) async {
    final favouritesJson =
        await store.record('favourites/${profile.id}').get(db) as String;
    if (favouritesJson != null) {
      final favouriteMovies = FavouriteMovies.fromJson(favouritesJson);
      if (!favouriteMovies.favouriteIDs.contains(movie.id)) {
        favouriteMovies.favouriteIDs.add(movie.id);
        await store
            .record('favourites/${profile.id}')
            .put(db, favouriteMovies.toJson());
      }
    } else {
      final favouriteMovies = FavouriteMovies(favouriteIDs: {movie.id});
      await store
          .record('favourites/${profile.id}')
          .put(db, favouriteMovies.toJson());
    }
  }

  Future<void> removeFavouriteMovie(
      {@required Profile profile, @required TMDBMovieBasic movie}) async {
    final favouritesJson =
        await store.record('favourites/${profile.id}').get(db) as String;
    if (favouritesJson != null) {
      final favouriteMovies = FavouriteMovies.fromJson(favouritesJson);
      if (favouriteMovies.favouriteIDs.contains(movie.id)) {
        favouriteMovies.favouriteIDs.remove(movie.id);
        await store
            .record('favourites/${profile.id}')
            .put(db, favouriteMovies.toJson());
      }
    }
  }

  Stream<FavouriteMovies> favouriteMovies(Profile profile) {
    final record = store.record('favourites/${profile.id}');
    return record.onSnapshot(db).map((snapshot) => snapshot != null
        ? FavouriteMovies.fromJson(snapshot.value)
        : FavouriteMovies());
  }
}
