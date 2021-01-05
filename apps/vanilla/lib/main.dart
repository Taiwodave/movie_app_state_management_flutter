import 'package:flutter/material.dart';
import 'package:tmdb_state_management_flutter/api/tmdb_api.dart';
import 'package:tmdb_state_management_flutter/app/now_playing_page.dart';
import 'package:tmdb_state_management_flutter/bloc/bloc_provider.dart';
import 'package:tmdb_state_management_flutter/bloc/movie_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: buildNowPlaying(),
    );
  }

  Widget buildNowPlaying() {
    return BlocProvider<MovieBloc>(
      child: NowPlayingPage(),
      bloc: MovieBloc(api: TMDBClient()),
    );
  }
}
