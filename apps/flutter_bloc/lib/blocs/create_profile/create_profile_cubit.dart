import 'package:core/models/profile.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/blocs/create_profile/create_profile_state.dart';
import 'package:uuid/uuid.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit({@required this.localDB, @required this.navigatorState})
      : super(const CreateProfileState.notSubmitted());
  final LocalDB localDB;
  final NavigatorState navigatorState;

  Future<void> createProfile(String name) async {
    if (name.isEmpty) {
      emit(const CreateProfileState.error('Name can\'t be empty'));
      return;
    }
    final nameExists = await localDB.profileExistsWithName(name);
    if (nameExists) {
      emit(const CreateProfileState.error('Name already taken'));
      return;
    }
    final id = Uuid().v1();
    emit(const CreateProfileState.loading());
    try {
      await localDB.createProfile(Profile(name: name, id: id));
      emit(const CreateProfileState.success());
    } catch (e) {
      emit(CreateProfileState.error(e.toString()));
    }
    navigatorState.pop();
  }
}
