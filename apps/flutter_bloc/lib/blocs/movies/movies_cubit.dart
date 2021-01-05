import 'dart:async';
import 'package:core/models/tmdb_movie_basic.dart';
import 'package:core/models/tmdb_movies_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/movies/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({@required this.api}) : super(const MoviesState.data([], false)) {
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
      emit(MoviesState.dataLoading(_movies));
      final TMDBMoviesResponse result = await api.nowPlayingMovies(page: _page);
      if (result.isEmpty) {
        emit(MoviesState.data(_movies, true));
      } else {
        emit(MoviesState.data(_movies..addAll(result.results), false));
      }
    } catch (e) {
      emit(MoviesState.error(e.toString()));
    }
  }
}
