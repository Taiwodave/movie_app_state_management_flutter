import 'package:core/models/tmdb_movie_basic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoviesState {
  MoviesState();
}

class MoviesError extends MoviesState {
  final String error;
  MoviesError(this.error);
}

// MoviesEmpty
class MoviesNoResults extends MoviesState {}

// MoviesResult
class MoviesPopulated extends MoviesState {
  MoviesPopulated({@required this.movies, @required this.isLoading});
  final List<TMDBMovieBasic> movies;
  final bool isLoading;

  MoviesPopulated copyWith({List<TMDBMovieBasic> movies, bool isLoading}) {
    return MoviesPopulated(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  MoviesPopulated update({List<TMDBMovieBasic> newMovies, bool isLoading}) {
    return MoviesPopulated(
      movies: newMovies != null ? (this..movies.addAll(newMovies)) : movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
