class ArtitstsModel {
  ArtitstsModel({
    required this.results,
  });
  late final List<ArtitstsResults> results;

  ArtitstsModel.fromJson(Map<String, dynamic> json) {
    results = List.from(json['results']).map((e) => ArtitstsResults.fromJson(e)).toList();
  }
}

class ArtitstsResults {
  ArtitstsResults({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });
  late final bool? adult;
  late final int? gender;
  late final int? id;
  late final List<KnownFor>? knownFor;
  late final String? knownForDepartment;
  late final String? name;
  late final double? popularity;
  late final String? profilePath;

  ArtitstsResults.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownFor = List.from(json['known_for']).map((e)=>KnownFor.fromJson(e)).toList();
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['known_for'] = knownFor!.map((e)=>e.toJson()).toList();
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}

class KnownFor {
  KnownFor({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  late final String? backdropPath;
  late final List<int>? genreIds;
  late final int? id;
  late final String? mediaType;
  late final String? originalLanguage;
  late final String? originalTitle;
  late final String? overview;
  late final String? posterPath;
  late final String? releaseDate;
  late final String? title;
  late final bool? video;
  late final num? voteAverage;
  late final int? voteCount;

  KnownFor.fromJson(Map<String, dynamic> json){
    backdropPath = json['backdrop_path'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backdrop_path'] = backdropPath;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['media_type'] = mediaType;
    _data['original_language'] = originalLanguage;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    _data['release_date'] = releaseDate;
    _data['title'] = title;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}
