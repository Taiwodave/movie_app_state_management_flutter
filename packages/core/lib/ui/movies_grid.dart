import 'package:core/models/app_models/favourite_movies.dart';
import 'package:flutter/material.dart';
import '../models/tmdb/tmdb_movie_basic.dart';
import '../ui/poster_tile.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({
    Key key,
    @required this.movies,
    this.favouriteMovies,
    @required this.controller,
    this.onFavouriteChanged,
  }) : super(key: key);
  final List<TMDBMovieBasic> movies;
  final FavouriteMovies favouriteMovies;
  final ScrollController controller;
  final Function(TMDBMovieBasic, bool) onFavouriteChanged;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenSize.width / 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 185.0 / 278.0,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final isFavourite =
            favouriteMovies?.favouriteIDs?.contains(movie.id) ?? false;
        return PosterTile(
          imagePath: movie.posterPath,
          //debugIndex: index,
          isFavourite: isFavourite,
          onFavouriteChanged: (isFavourite) =>
              onFavouriteChanged?.call(movie, isFavourite),
        );
      },
      controller: controller,
    );
  }
}
