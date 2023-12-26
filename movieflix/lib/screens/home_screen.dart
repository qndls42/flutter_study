import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/movie_widget.dart';
import 'package:movieflix/widgets/movie_with_title_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();

  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getPlayingMovies();

  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          '',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Popular Movies
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      child: makeMovieList(snapshot),
                    );
                  }
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              //* Now in Cinemas
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 210,
                      child: makeMovieListWithTitle(
                        snapshot,
                        imgWidth: 160,
                        imgHeight: 160,
                        imgFit: BoxFit.none,
                      ),
                    );
                  }
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              //* Coming Soon
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: comingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return SizedBox(
                        height: 210,
                        child: makeMovieListWithTitle(
                          snapshot,
                          imgWidth: 160,
                          imgHeight: 160,
                          // imgFit: BoxFit.fitHeight,
                        ),
                      );
                    }
                    return SizedBox(
                      height: 200,
                      child: Text(
                        'There are no up coming movies.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    );
                  }
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView makeMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var movieData = snapshot.data![index];
        return Movie(
          movieData: movieData,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      itemCount: snapshot.data!.length,
    );
  }

  ListView makeMovieListWithTitle(
    AsyncSnapshot<List<MovieModel>> snapshot, {
    double? imgWidth,
    double? imgHeight,
    BoxFit? imgFit,
  }) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var movieData = snapshot.data![index];
        return MovieWithTitle(
          movieData: movieData,
          imgWidth: imgWidth,
          imgHeight: imgHeight,
          imgFit: imgFit,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      itemCount: snapshot.data!.length,
    );
  }
}
