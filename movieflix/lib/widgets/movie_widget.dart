import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class Movie extends StatelessWidget {
  const Movie({
    super.key,
    required this.movieData,
  });

  final MovieModel movieData;

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
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Image.network(
          '${ApiService.imageBaseUrl}/${movieData.backdropImgPath}',
        ),
      ),
    );
  }
}
