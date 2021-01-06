import 'package:core/models/profile/profile.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core/models/app_state/create_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CreateProfileModel extends StateNotifier<CreateProfileState> {
  CreateProfileModel({@required this.localDB})
      : super(const CreateProfileState.notSubmitted());
  final LocalDB localDB;

  Future<bool> createProfile(String name) async {
    if (name.isEmpty) {
      state = CreateProfileState.error('Name can\'t be empty');
      return false;
    }
    final nameExists = await localDB.profileExistsWithName(name);
    if (nameExists) {
      state = CreateProfileState.error('Name already taken');
      return false;
    }
    final id = Uuid().v1();
    state = CreateProfileState.loading();
    try {
      await localDB.createProfile(Profile(name: name, id: id));
      state = CreateProfileState.success();
    } catch (e) {
      state = CreateProfileState.error(e.toString());
    }
    return true;
  }
}
