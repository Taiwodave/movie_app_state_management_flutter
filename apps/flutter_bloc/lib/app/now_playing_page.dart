import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/movies/movies_cubit.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/movies/movies_state.dart';
import 'package:core/ui/movies_grid.dart';

class NowPlayingPage extends StatefulWidget {
  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      final moviesCubit = BlocProvider.of<MoviesCubit>(context);
      moviesCubit.fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: buildContent(context),
      backgroundColor: Colors.black,
    );
  }

  Widget buildContent(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return state.when(
          data: (movies, _) => MoviesGrid(
            movies: movies,
            controller: _scrollController,
          ),
          dataLoading: (movies) {
            return movies.isEmpty
                ? _buildLoading()
                : MoviesGrid(
                    movies: movies,
                    controller: _scrollController,
                  );
          },
          error: (error) => Center(child: Text(error)),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
