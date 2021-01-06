import 'package:flutter/material.dart';
import 'package:core/api/tmdb_api.dart';
import 'package:transparent_image/transparent_image.dart';

class PosterTile extends StatelessWidget {
  const PosterTile({
    @required this.imagePath,
    // debugging hint to show the tile index
    this.debugIndex,
    @required this.isFavourite,
    this.onFavouriteChanged,
  });
  final String imagePath;
  final int debugIndex;
  final bool isFavourite;
  final ValueChanged<bool> onFavouriteChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _Poster(imagePath: imagePath),
        TopGradient(),
        if (debugIndex != null)
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              '$debugIndex',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        Positioned(
          right: 0,
          top: 0,
          child: _FavouriteButton(
            isFavourite: isFavourite,
            onFavouriteChanged: onFavouriteChanged,
          ),
        ),
      ],
    );
  }
}

class TopGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
          stops: [0.0, 0.3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}

class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton(
      {Key key, @required this.isFavourite, this.onFavouriteChanged})
      : super(key: key);
  final bool isFavourite;
  final ValueChanged<bool> onFavouriteChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onFavouriteChanged?.call(!isFavourite),
      child: Container(
        width: 36.0,
        height: 36.0,
        child: Icon(Icons.favorite,
            color: isFavourite ? Colors.red : Colors.white),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({@required this.imagePath});
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
