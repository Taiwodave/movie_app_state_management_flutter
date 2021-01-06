import 'package:core/models/profile.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final controller = TextEditingController();
  String _errorText;

  Future<void> createProfile(String name) async {
    if (name.isEmpty) {
      setState(() => _errorText = 'Name can\'t be empty');
      return;
    }
    final localDB = RepositoryProvider.of<LocalDB>(context);
    final nameExists = await localDB.profileExistsWithName(name);
    if (nameExists) {
      setState(() => _errorText = 'Name already taken');
      return;
    }
    final id = Uuid().v1();
    await localDB.createProfile(Profile(name: name, id: id));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
