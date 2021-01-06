import 'package:flutter/material.dart';
import 'package:core/ui/create_profile_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_demo_riverpod/app/create_profile/create_profile_model.dart';
import 'package:movie_app_demo_riverpod/top_level_providers.dart';

final createProfileModelProvider =
    StateNotifierProvider<CreateProfileModel>((ref) {
  final localDB = ref.watch(localDBProvider);
  return CreateProfileModel(localDB: localDB);
});

class CreateProfilePageBuilder extends ConsumerWidget {
  Future<void> createProfile(BuildContext context, String name) async {
    final model = context.read(createProfileModelProvider);
    final success = await model.createProfile(name);
    if (success) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(createProfileModelProvider.state);
    return CreateProfilePage(
      onSubmit: (name) => createProfile(context, name),
      errorText: state.maybeWhen(
        error: (error) => error,
        orElse: () => null,
      ),
    );
  }
}
