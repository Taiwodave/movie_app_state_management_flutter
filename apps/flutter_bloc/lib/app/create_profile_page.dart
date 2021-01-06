import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/create_profile/create_profile_cubit.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/create_profile/create_profile_state.dart';

class CreateProfilePage extends StatefulWidget {
  static Widget create(BuildContext context) {
    final localDB = RepositoryProvider.of<LocalDB>(context);
    return BlocProvider<CreateProfileCubit>(
      create: (_) => CreateProfileCubit(
        localDB: localDB,
        navigatorState: Navigator.of(context),
      ),
      child: CreateProfilePage(),
    );
  }

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final controller = TextEditingController();
  String _errorText;

  // Should be a bloc
  Future<void> createProfile(String name) async {
    final cubit = BlocProvider.of<CreateProfileCubit>(context);
    await cubit.createProfile(name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Profile'),
            actions: [
              FlatButton(
                onPressed: () => createProfile(controller.value.text),
                child: const Text('Save'),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(32.0),
            alignment: Alignment.center,
            child: ProfileNameInput(
              controller: controller,
              errorText: _errorText,
              onSubmitted: (value) => createProfile(value),
            ),
          ),
        );
      },
    );
  }
}

class ProfileNameInput extends StatelessWidget {
  const ProfileNameInput(
      {Key key,
      @required this.controller,
      this.errorText,
      @required this.onSubmitted})
      : super(key: key);
  final TextEditingController controller;
  final String errorText;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    // TODO: Styling
    return TextField(
      controller: controller,
      decoration: InputDecoration(errorText: errorText),
      onSubmitted: onSubmitted,
    );
  }
}
