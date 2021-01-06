import 'package:core/models/profile.dart';
import 'package:core/models/profiles_data.dart';
import 'package:core/persistence/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_flutter_bloc_demo/app/create_profile_page.dart';

class ProfilesSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile selection'),
      ),
      body: ProfilesGrid(),
    );
  }
}

class ProfilesGrid extends StatelessWidget {
  Future<void> addProfile(BuildContext context) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreateProfilePage.create(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localDB = RepositoryProvider.of<LocalDB>(context);
    return StreamBuilder<ProfilesData>(
      stream: localDB.profiles(),
      builder: (_, snapshot) {
        final List<Profile> profiles =
            snapshot.hasData ? snapshot.data.profiles.values.toList() : [];
        final screenSize = MediaQuery.of(context).size;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (screenSize.width - 32.0) / 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 185.0 / 278.0,
            ),
            itemCount: profiles.length + 1,
            itemBuilder: (context, index) {
              if (index < profiles.length) {
                return ProfileTile(
                  profile: profiles[index],
                  selected: false,
                  onPressed: () {
                    // TODO: Select profile in DB, move to movies page
                  },
                );
              }
              return AddProfileButton(
                onPressed: () => addProfile(context),
              );
            },
          ),
        );
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {Key key,
      @required this.profile,
      @required this.selected,
      this.onPressed})
      : super(key: key);
  final Profile profile;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: selected
                      ? Border.all(
                          color: Colors.white,
                          width: 3,
                        )
                      : null),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(profile.name),
        ],
      ),
    );
  }
}

class AddProfileButton extends StatelessWidget {
  const AddProfileButton({Key key, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  )),
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 8.0),
          const Text('Add Profile'),
        ],
      ),
    );
  }
}
