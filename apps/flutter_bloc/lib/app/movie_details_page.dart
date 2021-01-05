import 'package:core/models/tmdb_movie_basic.dart';
import 'package:flutter/material.dart';

// Any point navigating here? this would only present the movie details but not require any state management
class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key key, this.movie}) : super(key: key);
  final TMDBMovieBasic movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
    );
  }
}
