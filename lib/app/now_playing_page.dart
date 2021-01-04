import 'package:flutter/material.dart';
import 'package:tmdb_state_management_flutter/app/poster_tile.dart';
import 'package:tmdb_state_management_flutter/bloc/bloc_provider.dart';
import 'package:tmdb_state_management_flutter/bloc/movie_bloc.dart';
import 'package:tmdb_state_management_flutter/bloc/movies_state.dart';
import 'package:models/tmdb_movie_basic.dart';

class NowPlayingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
      ),
      body: buildContent(context),
      backgroundColor: Colors.black,
    );
  }

  Widget buildContent(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return StreamBuilder(
      stream: movieBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is MoviesPopulated) {
            return buildList(context, data.movies);
          }
          if (data is MoviesLoading) {
            return buildLoading();
          }
        }
        return buildLoading();
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildList(BuildContext context, List<TMDBMovieBasic> movies) {
    Size screenSize = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: screenSize.width / 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 185.0 / 278.0,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return PosterTile(imagePath: movie.posterPath);
      },
    );
  }
}
