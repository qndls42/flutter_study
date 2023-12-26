import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String movieBaseUrl =
      'https://movies-api.nomadcoders.workers.dev';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const String popular = 'popular';
  static const String nowPlaying = 'now-playing';
  static const String comingSoon = 'coming-soon';

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$movieBaseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final movies = responseBody['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getPlayingMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$movieBaseUrl/$nowPlaying');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final maxDate = responseBody['dates']['maximum'];
      final minDate = responseBody['dates']['minimum'];

      final movies = responseBody['results'];
      for (var movie in movies) {
        final releaseDate = movie['release_date'];
        bool isAfterMinDate =
            DateTime.parse(releaseDate).isAfter(DateTime.parse(minDate));
        bool isBeforeMaxDate =
            DateTime.parse(releaseDate).isBefore(DateTime.parse(maxDate));
        if (isAfterMinDate && isBeforeMaxDate) {
          final instance = MovieModel.fromJson(movie);
          movieInstances.add(instance);
        }
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$movieBaseUrl/$comingSoon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final maxDate = responseBody['dates']['maximum'];
      final minDate = responseBody['dates']['minimum'];

      final movies = responseBody['results'];
      for (var movie in movies) {
        final releaseDate = movie['release_date'];
        bool isAfterMinDate =
            DateTime.parse(releaseDate).isAfter(DateTime.parse(minDate));
        bool isBeforeMaxDate =
            DateTime.parse(releaseDate).isBefore(DateTime.parse(maxDate));
        if (isAfterMinDate && isBeforeMaxDate) {
          final instance = MovieModel.fromJson(movie);
          movieInstances.add(instance);
        }
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetail({required int id}) async {
    final url = Uri.parse('$movieBaseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return MovieDetailModel.fromJson(responseBody);
    }

    throw Error();
  }
}
