import 'package:core/api/tmdb_api.dart';
import 'package:flutter/material.dart';
import 'package:core/ui/movies_grid.dart';
import 'package:core/ui/scrollable_movies_page_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/app/now_playing/movies_model.dart';

final moviesModelProvider =
    StateNotifierProvider<MoviesModel>((ref) => MoviesModel(api: TMDBClient()));

class NowPlayingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ScrollableMoviesPageBuilder(
      onNextPageRequested: () {
        final moviesModel = context.read(moviesModelProvider);
        moviesModel.fetchNextPage();
      },
      builder: (context, controller) {
        final state = watch(moviesModelProvider.state);
        return state.when(
          data: (movies, _) => MoviesGrid(
            movies: movies,
            controller: controller,
          ),
          dataLoading: (movies) {
            return movies.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MoviesGrid(
                    movies: movies,
                    controller: controller,
                  );
          },
          error: (error) => Center(child: Text(error)),
        );
      },
    );
  }
}
