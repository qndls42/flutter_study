class MovieDetailModel {
  late final List<String> genres = []; // List<{id,name}>
  late final int id;
  late final String overview;
  late final String posterImgPath;
  late final String title;
  late final double voteAverage;
  late final int runtime;

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    final genreList = json['genres'];
    for (var genre in genreList) {
      genres.add(genre['name'].toString());
    }
    id = json['id'];
    overview = json['overview'];
    posterImgPath = json['poster_path'];
    title = json['title'];
    voteAverage = json['vote_average'];
    runtime = json['runtime'];
  }
}
