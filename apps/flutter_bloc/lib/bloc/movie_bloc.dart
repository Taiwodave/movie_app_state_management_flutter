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

// class MovieBloc extends BlocBase {
//   TMDBClient api;
//   int page = 0;

//   //an instance of the MoviesPopulated state that will be used for each Bloc implementation
//   MoviesPopulated moviesPopulated = MoviesPopulated([]);

//   // This is the internal object whose stream/sink is provided by this component
//   final _streamController = BehaviorSubject<MoviesState>();

//   // This is the stream of movies. Use this to show the contents
//   Stream<MoviesState> get stream => _streamController.stream;

//   // final _nextPageController = StreamController();

//   // Sink get nextPage => _nextPageController.sink;

//   MovieBloc({this.api}) {
// //    _nextPageController.stream.listen(fetchNextPage);
//     init();
//   }

//   void init() {
//     if (page == 0) {
//       fetchNextPage();
//     }
//   }

//   @override
//   void dispose() {
//     print('closing movie bloc stream $this');
//     _streamController.close();
// //    _nextPageController.close();
//   }

//   void fetchNextPage([Object event]) {
//     _streamController.addStream(fetchMoviesFromNetwork());
//   }

//   Stream<MoviesState> fetchMoviesFromNetwork() async* {
//     if (moviesPopulated.movies.isEmpty) {
//       yield MoviesLoading();
//     }

//     page += 1;
//     try {
//       final result = await api.nowPlayingMovies(page: page);
//       if (result.isEmpty) {
//         yield MoviesEmpty();
//       } else {
//         yield moviesPopulated.update(newMovies: result.results);
//       }
//     } catch (e) {
//       print('error $e');
//       yield MoviesError(e.toString());
//     }
//   }
// }
