import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tmdb_state_management_flutter/api/tmdb_api.dart';
import 'package:tmdb_state_management_flutter/bloc/bloc_provider.dart';
import 'package:tmdb_state_management_flutter/bloc/movies_state.dart';

class MovieBloc extends BlocBase {
  TMDBClient api;
  int page = 0;

  //an instance of the MoviesPopulated state that will be used for each Bloc implementation
  MoviesPopulated moviesPopulated = MoviesPopulated([]);

  // This is the internal object whose stream/sink is provided by this component
  final _streamController = BehaviorSubject<MoviesState>();

  // This is the stream of movies. Use this to show the contents
  Stream<MoviesState> get stream => _streamController.stream;

  final _nextPageController = StreamController();

  Sink get nextPage => _nextPageController.sink;

  MovieBloc({this.api}) {
    _nextPageController.stream.listen(fetchNextPage);
    init();
  }

  void init() {
    if (page == 0) {
      fetchNextPage();
    }
  }

  void dispose() {
    print('closing movie bloc stream $this');
    _streamController.close();
    _nextPageController.close();
  }

  void fetchNextPage([event]) {
    _streamController.addStream(fetchMoviesFromNetwork());
  }

  Stream<MoviesState> fetchMoviesFromNetwork() async* {
    if (moviesPopulated.movies.isEmpty) {
      yield MoviesLoading();
    }

    page += 1;
    try {
      final result = await api.nowPlayingMovies(page: page);
      if (result.isEmpty) {
        yield MoviesEmpty();
      } else {
        yield moviesPopulated.update(newMovies: result.results);
      }
    } catch (e) {
      print('error $e');
      yield MoviesError(e.toString());
    }
  }
}
