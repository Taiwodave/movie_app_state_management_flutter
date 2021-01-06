import '../tmdb/tmdb_movie_basic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_state.freezed.dart';

@freezed
abstract class MoviesState with _$MoviesState {
  const factory MoviesState.data(
      List<TMDBMovieBasic> movies, bool hasReachedMax) = _Data;
  const factory MoviesState.dataLoading(List<TMDBMovieBasic> movies) =
      _DataLoading;
  const factory MoviesState.error(String error) = _Error;
}
