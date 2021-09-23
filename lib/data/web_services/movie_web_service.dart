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
}
