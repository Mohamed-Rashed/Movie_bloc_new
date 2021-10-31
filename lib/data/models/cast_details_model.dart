class CastDetailsModel {
  CastDetailsModel({
    required this.adult,
    required this.biography,
    required this.birthday,
    required this.gender,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
  late final bool adult;
  late final String biography;
  late final String birthday;
  late final int gender;
  late final int id;
  late final String imdbId;
  late final String knownForDepartment;
  late final String name;
  late final String placeOfBirth;
  late final double popularity;
  late final String profilePath;

  CastDetailsModel.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    biography = json['biography'];
    birthday = json['birthday'];
    gender = json['gender'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['biography'] = biography;
    _data['birthday'] = birthday;
    _data['gender'] = gender;
    _data['id'] = id;
    _data['imdb_id'] = imdbId;
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['place_of_birth'] = placeOfBirth;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}