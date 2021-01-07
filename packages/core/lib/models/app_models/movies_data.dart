import 'dart:convert';

import 'package:core/models/tmdb/tmdb_movie_basic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MoviesData {
  final Map<int, TMDBMovieBasic> movies;
  MoviesData({
    this.movies,
  });

  Map<int, TMDBMovieBasic> toMap() => movies;

  factory MoviesData.fromMap(Map<int, dynamic> map) {
    if (map == null) return null;

    final movies = map.map((key, value) => MapEntry<int, TMDBMovieBasic>(
          key,
          TMDBMovieBasic.fromJson(value),
        ));

    return MoviesData(
      movies: movies,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesData.fromJson(String source) =>
      MoviesData.fromMap(json.decode(source));

  @override
  String toString() => 'MoviesData(movies: $movies)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return o is MoviesData && mapEquals(o.movies, movies);
  }

  @override
  int get hashCode => movies.hashCode;
}
