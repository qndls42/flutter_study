class MovieModel {
  final bool adult;
  final String backdropImgPath;
  final List<dynamic> genreIds; // List<int>
  final int id;
  final String orgLang;
  final String orgTitle;
  final String overview;
  final double popularity;
  final String posterImgPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropImgPath = json['backdrop_path'],
        genreIds = json['genre_ids'],
        id = json['id'],
        orgLang = json['original_language'],
        orgTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterImgPath = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}
