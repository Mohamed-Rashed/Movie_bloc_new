import 'package:movie_app_blocd/data/models/artists_model.dart';
import 'package:movie_app_blocd/data/models/cast_details_model.dart';
import 'package:movie_app_blocd/data/models/genres_model.dart';
import 'package:movie_app_blocd/data/models/movie_characters.dart';
import 'package:movie_app_blocd/data/models/movie_details_model.dart';
import 'package:movie_app_blocd/data/models/movie_videos_model.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/web_services/movie_web_service.dart';

class MovieRepository {
  late final MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);

  Future<List<GenresModel>> getAllGenres() async {
    final genres = await movieWebServices.getAllGenres();
    return genres.map((genre) => GenresModel.fromJson(genre)).toList();
  }

  /////////////////////////////////////////////////////////////

  Future<List<PopularMoviesModel>> getPopularMovies() async {
    final popularMovies = await movieWebServices.getPopularMovies();
    return popularMovies
        .map((popularMovies) => PopularMoviesModel.fromJson(popularMovies))
        .toList();
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<List<PopularMoviesModel>> getMoviesbyGenres(int genresID) async {
    final popularMovies = await movieWebServices.getMoviesbyGenres(genresID);
    return popularMovies
        .map((popularMovies) => PopularMoviesModel.fromJson(popularMovies))
        .toList();
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<List<MovieDetailsModel>> getMoviesDetails(int movieId) async {
    final movieDetails = await movieWebServices.getMoviesDetails(movieId);
    return movieDetails
        .map((movieDetails) => MovieDetailsModel.fromJson(movieDetails))
        .toList();
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<List<MovieCharacters>> getMoviesCharacters(int movieId) async {
    final movieCharacters = await movieWebServices.getMoviesCharacters(movieId);
    return movieCharacters
        .map((movieCharacters) => MovieCharacters.fromJson(movieCharacters))
        .toList();
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<List<MovieVideosModel>> getMoviesVideos(int movieId) async {
    final moviesVideos = await movieWebServices.getMoviesVideos(movieId);
    return moviesVideos
        .map((moviesVideos) => MovieVideosModel.fromJson(moviesVideos))
        .toList();
  }


  /////////////////////////////////////////////////////////////////////////////

  Future<List<PopularMoviesModel>> getSearchedMovie(String searchName) async {
    final searchedMovies = await movieWebServices.getSearchedMovie(searchName);
    return searchedMovies
        .map((searchedMovies) => PopularMoviesModel.fromJson(searchedMovies))
        .toList();
  }


  /////////////////////////////////////////////////////////////////////////////

  Future<List<PopularMoviesModel>> getSimilarMovies(int movieID) async {
    final similarMovies = await movieWebServices.getSimilarMovies(movieID);
    return similarMovies
        .map((similarMovies) => PopularMoviesModel.fromJson(similarMovies))
        .toList();
  }


  /////////////////////////////////////////////////////////////////////////////

  Future<List<PopularMoviesModel>> getCastMovies(int castID) async {
    final moviesCast = await movieWebServices.getCastMovies(castID);
    return moviesCast
        .map((moviesCast) => PopularMoviesModel.fromJson(moviesCast))
        .toList();
  }


  /////////////////////////////////////////////////////////////////////////////

  Future<List<CastDetailsModel>> getCastDetails(int castID) async {
    final castDetails = await movieWebServices.getCastDetails(castID);
    return castDetails
        .map((castDetails) => CastDetailsModel.fromJson(castDetails))
        .toList();
  }


  /////////////////////////////////////////////////////////////////////////////

  Future<List<ArtitstsModel>> getArtistsSearch(String artistName) async {
    final artist = await movieWebServices.getArtistsSearch(artistName);
    return artist
        .map((artistName) => ArtitstsModel.fromJson(artistName))
        .toList();
  }
}
