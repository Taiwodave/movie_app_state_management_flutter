import 'package:core/models/app_models/profiles_data.dart';
import 'package:core/models/tmdb/tmdb_movie_basic.dart';
import 'package:core/persistence/data_store.dart';
import 'package:core/ui/movies_grid.dart';
import 'package:core/ui/scrollable_movies_page_builder.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteMoviesRepository {
  FavouriteMoviesRepository(
      {@required this.dataStore, @required this.profilesData});
  final DataStore dataStore;
  final ProfilesData profilesData;

  Stream<List<TMDBMovieBasic>> favouriteMovies() {
    if (profilesData?.selectedId != null) {
      return Rx.combineLatest2(dataStore.allSavedMovies(),
          dataStore.favouriteMovies(profileId: profilesData.selectedId),
          (List<TMDBMovieBasic> movies, List<int> favourites) {
        return movies.where((movie) => favourites.contains(movie.id)).toList();
      });
    }
    return const Stream.empty();
  }
}

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key key, this.favouriteMoviesRepository})
      : super(key: key);
  final FavouriteMoviesRepository favouriteMoviesRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TMDBMovieBasic>>(
      stream: favouriteMoviesRepository.favouriteMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return ScrollableMoviesPageBuilder(
              title: 'Favourites',
              builder: (_, __) => MoviesGrid(movies: movies),
            );
          } else {
            return Container();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
