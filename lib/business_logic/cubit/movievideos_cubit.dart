import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/movie_videos_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'movievideos_state.dart';

class MovievideosCubit extends Cubit<MovievideosState> {
  final MovieRepository movieRepository;
  List<MovieVideosModel> movieVideos = [];
  MovievideosCubit(this.movieRepository) : super(MovievideosInitial());

  List<MovieVideosModel> getMoviesVideos(int movieId) {
    movieRepository.getMoviesVideos(movieId).then((movieVideos) {
      emit(MovieVideosLoaded(movieVideos));
      this.movieVideos = movieVideos;
    });
    return movieVideos;
  }
}
