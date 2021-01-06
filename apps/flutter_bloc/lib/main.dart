import 'package:flutter/material.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb_flutter_bloc_demo/app/now_playing_page.dart';
import 'package:tmdb_flutter_bloc_demo/app/profile_selection_page.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/movies/movies_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize DB
  final appDocDir = await getApplicationDocumentsDirectory();
  final localDb = await LocalDB.init('${appDocDir.path}/profiles.db');
  runApp(RepositoryProvider<LocalDB>(
    create: (_) => localDb,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData.dark().copyWith(/*scaffoldBackgroundColor: Colors.indigo*/),
      home: ProfilesSelectionPage(), //buildNowPlaying(),
    );
  }

  Widget buildNowPlaying() {
    return BlocProvider<MoviesCubit>(
      create: (_) => MoviesCubit(api: TMDBClient()),
      child: NowPlayingPage(),
    );
  }
}
