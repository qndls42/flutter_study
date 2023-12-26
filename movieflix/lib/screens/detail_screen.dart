import 'package:flutter/material.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/models/movie_detail_model.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  final String posterPath;
  late final Future<MovieDetailModel> detail;

  DetailScreen({super.key, required this.id, required this.posterPath}) {
    detail = ApiService.getMovieDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Back to list',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('${ApiService.imageBaseUrl}/$posterPath'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                  left: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    FutureBuilder(
                      future: detail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var movieData = snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movieData.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 30,
                                    color: Colors.yellow.shade600,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    movieData.voteAverage.toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    minutesToString(movieData.runtime),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    ' | ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    genresToString(movieData.genres),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                'Storyline',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 350,
                                child: Text(
                                  movieData.overview,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Center(
                child: SizedBox(
                  width: 260,
                  height: 60,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFF7D757),
                    ),
                    child: const Text(
                      'Buy Ticket',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String minutesToString(int runtime) {
    var d = Duration(minutes: runtime);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }

  String genresToString(List<String> genres) {
    String totalGenres = genres.join(', ');
    return totalGenres;
  }
}
