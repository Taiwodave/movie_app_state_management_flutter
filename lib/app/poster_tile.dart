import 'package:flutter/material.dart';
import 'package:tmdb_state_management_flutter/api/tmdb_api.dart';
import 'package:transparent_image/transparent_image.dart';

class PosterTile extends StatelessWidget {
  PosterTile({@required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TMDBApi.imageUrl(imagePath, PosterSize.w154),
        fit: BoxFit.fitWidth,
      );
    }
    return Image.memory(kTransparentImage);
  }
}
