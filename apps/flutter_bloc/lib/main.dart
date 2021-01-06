import 'package:flutter/material.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb_flutter_bloc_demo/app/app_startup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize DB
  final appDocDir = await getApplicationDocumentsDirectory();
  // sembast.db: Andrea, Chiara, Lisa
  final localDb = await LocalDB.init('${appDocDir.path}/sembast2.db');
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(),
      home: AppStartupPage.create(context),
    );
  }
}
