import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class MovieWithTitle extends StatelessWidget {
  const MovieWithTitle({
    super.key,
    required this.movieData,
    this.imgWidth,
    this.imgHeight,
    this.imgFit,
  });

  final MovieModel movieData;
  final double? imgWidth;
  final double? imgHeight;
  final BoxFit? imgFit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: movieData.id,
              posterPath: movieData.posterImgPath,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
            ),
            width: imgWidth,
            height: imgHeight,
            child: Image.network(
              '${ApiService.imageBaseUrl}/${movieData.backdropImgPath}',
              fit: imgFit,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: imgWidth,
            child: Text(
              movieData.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
