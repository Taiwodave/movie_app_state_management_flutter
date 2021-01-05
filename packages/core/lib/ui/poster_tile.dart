import 'package:flutter/material.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:transparent_image/transparent_image.dart';

class DebugPosterTile extends StatelessWidget {
  const DebugPosterTile({@required this.imagePath, @required this.debugIndex});
  final String imagePath;
  final int debugIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PosterTile(imagePath: imagePath),
        Positioned(
          left: 10,
          top: 10,
          child: Text(
            '$debugIndex',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

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
