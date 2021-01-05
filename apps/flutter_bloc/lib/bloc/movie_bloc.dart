import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:tmdb_flutter_bloc_demo/bloc/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({@required this.api}) : super(MoviesLoading()) {
    init();
  }

  TMDBClient api;
  int page = 0;

  //an instance of the MoviesPopulated state that will be used for each Bloc implementation
  MoviesPopulated moviesPopulated = MoviesPopulated([]);

  void init() {
    if (page == 0) {
      fetchMoviesFromNetwork();
    }
  }

  Future<void> fetchMoviesFromNetwork() async {
    if (moviesPopulated.movies.isEmpty) {
      emit(MoviesLoading());
    }

    page += 1;
    try {
      final result = await api.nowPlayingMovies(page: page);
      if (result.isEmpty) {
        emit(MoviesEmpty());
      } else {
        emit(moviesPopulated.update(newMovies: result.results));
      }
    } catch (e) {
      print('error $e');
      emit(MoviesError(e.toString()));
    }
  }
}
