import 'package:flutter/material.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:transparent_image/transparent_image.dart';

class PosterTile extends StatelessWidget {
  const PosterTile({@required this.imagePath});
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
