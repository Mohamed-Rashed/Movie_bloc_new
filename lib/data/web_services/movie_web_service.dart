import 'package:dio/dio.dart';
import 'package:movie_app_blocd/constant/strings.dart';

class MovieWebServices {
  late Dio dio;

  MovieWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllGenres() async {
    List<dynamic> myData = [];
    try {
      Response response =
          await dio.get('genre/movie/list?api_key=${myApikey}&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  ///////////////////////////////////////////////////////////////


  Future<List<dynamic>> getPopularMovies() async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('movie/popular?api_key=${myApikey}&language=en-US&page=1');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  //////////////////////////////////////////////////////////////

  Future<List<dynamic>> getMoviesbyGenres(int genresID) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('discover/movie?api_key=$myApikey&with_genres=$genresID');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getMoviesDetails(int movieId) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('movie/$movieId?api_key=$myApikey&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getMoviesCharacters(int movieId) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('movie/$movieId/credits?api_key=$myApikey&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getMoviesVideos(int movieId) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('movie/$movieId/videos?api_key=$myApikey&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getSearchedMovie(String searchName) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('search/movie?api_key=$myApikey&language=en-US&query=$searchName&page=1&include_adult=false');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getSimilarMovies(int movieID) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('movie/$movieID/similar?api_key=$myApikey&language=en-US&page=1');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getCastMovies(int castID) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('person/$castID/movie_credits?api_key=$myApikey&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getCastDetails(int castID) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('person/$castID?api_key=$myApikey&language=en-US');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



  ////////////////////////////////////////////////////////////////

  Future<List<dynamic>> getArtistsSearch(String artistName) async {
    List<dynamic> myData = [];
    try {
      Response response = await dio
          .get('search/person?query=$artistName&api_key=$myApikey');
      print(response.data.toString());
      myData.add(response.data);
      return myData;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
