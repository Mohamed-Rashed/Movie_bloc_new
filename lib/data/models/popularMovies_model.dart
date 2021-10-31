class PopularMoviesModel {
  PopularMoviesModel({
    required this.results,
  });
  late final List<Results> results;

  PopularMoviesModel.fromJson(Map<String, dynamic> json) {
    results = json['results'] != null
        ? List.from(json['results']).map((e) => Results.fromJson(e)).toList()
        : List.from(json['cast']).map((e) => Results.fromJson(e)).toList();
  }
}

class Results {
  Results({
    required this.adult,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  late final bool? adult;
  late final int? id;
  late final String? originalTitle;
  late final String? overview;
  late final num? popularity;
  late final String? posterPath;
  late final String? releaseDate;
  late final String? title;
  late final bool? video;
  late final num? voteAverage;
  late final int? voteCount;

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    id = json['id'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['id'] = id;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['release_date'] = releaseDate;
    _data['title'] = title;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}
