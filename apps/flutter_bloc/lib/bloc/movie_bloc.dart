import 'dart:async';
import 'package:core/models/tmdb_movie_basic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:tmdb_flutter_bloc_demo/bloc/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({@required this.api})
      : super(MoviesPopulated(movies: [], isLoading: false)) {
    init();
  }

  TMDBClient api;

  // Keep track of some variables
  int _page = 0;
  bool _isLoadingNextPage = false;
  final List<TMDBMovieBasic> _movies = [];

  void init() {
    if (_page == 0) {
      fetchNextPage();
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingNextPage) {
      return;
    }

    _page += 1;
    try {
      _isLoadingNextPage = true;
      emit(MoviesPopulated(movies: _movies, isLoading: true));
      final result = await api.nowPlayingMovies(page: _page);
      _isLoadingNextPage = false;
      if (_page == 1 && result.isEmpty) {
        emit(MoviesNoResults());
      } else {
        emit(MoviesPopulated(
            movies: _movies..addAll(result.results), isLoading: false));
      }
    } catch (e) {
      print('error $e');
      emit(MoviesError(e.toString()));
    }
  }
}
