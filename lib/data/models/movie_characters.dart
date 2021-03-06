class MovieCharacters {
  MovieCharacters({
    required this.id,
    required this.cast,
  });
  late final int id;
  late final List<Cast> cast;

  MovieCharacters.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cast = List.from(json['cast']).map((e)=>Cast.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cast'] = cast.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
  });
  late final bool adult;
  late final int gender;
  late final int id;
  late final String knownForDepartment;
  late final String name;
  late final double popularity;
  late final String? profilePath;


  Cast.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
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
    _data['known_for_department'] = knownForDepartment;
    _data['name'] = name;
    _data['popularity'] = popularity;
    _data['profile_path'] = profilePath;
    return _data;
  }
}

