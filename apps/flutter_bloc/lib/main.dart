import 'package:flutter/material.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/app/now_playing_page.dart';
import 'package:tmdb_flutter_bloc_demo/bloc/movie_bloc.dart';

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
    return BlocProvider<MoviesCubit>(
      create: (_) => MoviesCubit(api: TMDBClient()),
      child: NowPlayingPage(),
    );
  }
}
