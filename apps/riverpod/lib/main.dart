import 'package:flutter/material.dart';
import 'package:core/persistence/sembast_data_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/app/app_startup/app_startup_page.dart';
import 'package:movie_app_demo_riverpod/top_level_providers.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize DB
  final appDocDir = await getApplicationDocumentsDirectory();
  // sembast.db: Andrea, Chiara, Lisa
  final dataStore =
      await SembastDataStore.init('${appDocDir.path}/sembast2.db');
  runApp(ProviderScope(
    overrides: [
      dataStoreProvider.overrideWithValue(dataStore),
    ],
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
      home: AppStartupPage(),
    );
  }
}
