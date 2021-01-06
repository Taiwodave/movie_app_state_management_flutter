import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/models/app_state/create_profile_state.dart';
import 'package:core/ui/create_profile_page.dart';
import 'package:movie_app_demo_flutter_bloc/app/create_profile/create_profile_cubit.dart';

class CreateProfilePageBuilder extends StatelessWidget {
  static Widget create(BuildContext context) {
    final localDB = RepositoryProvider.of<LocalDB>(context);
    return BlocProvider<CreateProfileCubit>(
      create: (_) => CreateProfileCubit(
        localDB: localDB,
        navigatorState: Navigator.of(context),
      ),
      child: CreateProfilePageBuilder(),
    );
  }

  Future<void> createProfile(BuildContext context, String name) async {
    final cubit = BlocProvider.of<CreateProfileCubit>(context);
    await cubit.createProfile(name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
        builder: (context, state) {
      return CreateProfilePage(
        onSubmit: (name) => createProfile(context, name),
        errorText: state.maybeWhen(
          error: (error) => error,
          orElse: () => null,
        ),
      );
    });
  }
}
