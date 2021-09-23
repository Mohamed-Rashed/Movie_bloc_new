class GenresModel {
  GenresModel({
    required this.genres,
  });
  late final List<Genres> genres;

  GenresModel.fromJson(Map<String, dynamic> json){
    genres = List.from(json['genres']).map((e)=>Genres.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Genres.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}