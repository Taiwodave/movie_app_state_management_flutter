import 'dart:async';
import 'package:core/models/tmdb/tmdb_movie_basic.dart';
import 'package:core/models/tmdb/tmdb_movies_response.dart';
import 'package:flutter/foundation.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:core/models/app_state/movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesModel extends StateNotifier<MoviesState> {
  MoviesModel({@required this.api}) : super(const MoviesState.data([], false)) {
    init();
  }

  final TMDBClient api;

  // Keep track of some variables
  int _page = 0;
  final List<TMDBMovieBasic> _movies = [];

  void init() {
    if (_page == 0) {
      fetchNextPage();
    }
  }

  bool get _canLoadNextPage => state.maybeWhen(
        dataLoading: (_) => false,
        data: (_, hasReachedMax) => !hasReachedMax,
        orElse: () => false,
      );

  Future<void> fetchNextPage() async {
    if (!_canLoadNextPage) {
      return;
    }

    _page += 1;
    try {
      state = MoviesState.dataLoading(_movies);
      final TMDBMoviesResponse result = await api.nowPlayingMovies(page: _page);
      if (result.isEmpty) {
        state = MoviesState.data(_movies, true);
      } else {
        state = MoviesState.data(_movies..addAll(result.results), false);
      }
    } catch (e) {
      state = MoviesState.error(e.toString());
    }
  }
}
