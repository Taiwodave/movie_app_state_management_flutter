import 'package:flutter/material.dart';
import '../models/app_models/profile.dart';

class ProfileGridItem extends StatelessWidget {
  const ProfileGridItem(
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
