import 'package:core/models/tmdb/tmdb_movie_basic.dart';
import 'package:core/models/app_models/favourite_movies.dart';
import 'package:core/ui/movies_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/top_level_providers.dart';

final favouriteMoviesProvider =
    StreamProvider.autoDispose<FavouriteMovies>((ref) {
  final dataStore = ref.watch(dataStoreProvider);
  final profilesData = ref.watch(profilesDataProvider);
  if (profilesData?.selectedId != null) {
    return dataStore.favouriteMovies(profilesData.selectedId);
  }
  return Stream.empty();
});

class FavouritesMovieGrid extends ConsumerWidget {
  const FavouritesMovieGrid(
      {Key key, @required this.movies, @required this.controller})
      : super(key: key);
  final List<TMDBMovieBasic> movies;
  final ScrollController controller;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dataStore = watch(dataStoreProvider);
    final profilesData = watch(profilesDataProvider);
    final favouriteMovies = watch(favouriteMoviesProvider);
    print(favouriteMovies);
    return favouriteMovies.when(
      data: (favourites) => MoviesGrid(
        movies: movies,
        favouriteMovies: favourites,
        controller: controller,
        onFavouriteChanged: (movie, isFavourite) async {
          if (profilesData?.selectedId != null) {
            await dataStore.setFavouriteMovie(
                profileId: profilesData.selectedId,
                movie: movie,
                isFavourite: isFavourite);
          }
        },
      ),
      loading: () => MoviesGrid(
        movies: movies,
        controller: controller,
      ),
      error: (_, __) => MoviesGrid(
        movies: movies,
        controller: controller,
      ),
    );
  }
}
