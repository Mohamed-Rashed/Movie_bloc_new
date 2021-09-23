import 'package:movie_app_blocd/data/models/genres_model.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/web_services/movie_web_service.dart';

class MovieRepository {
  late final MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);

  Future<List<GenresModel>> getAllGenres() async {
    final genres = await movieWebServices.getAllGenres();
    return genres.map((genre) => GenresModel.fromJson(genre)).toList();
  }

  Future<List<PopularMoviesModel>> getPopularMovies() async {
    final popularMovies = await movieWebServices.getPopularMovies();
    return popularMovies
        .map((popularMovies) => PopularMoviesModel.fromJson(popularMovies))
        .toList();
  }
}
