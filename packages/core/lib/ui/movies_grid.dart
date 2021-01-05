import 'package:flutter/material.dart';
import '../models/tmdb_movie_basic.dart';
import '../ui/poster_tile.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({Key key, this.movies, this.controller}) : super(key: key);
  final List<TMDBMovieBasic> movies;
  final ScrollController controller;

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
        return DebugPosterTile(imagePath: movie.posterPath, debugIndex: index);
      },
      controller: controller,
    );
  }
}
