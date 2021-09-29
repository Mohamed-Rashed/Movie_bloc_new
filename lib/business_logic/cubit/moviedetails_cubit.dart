import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/movie_details_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'moviedetails_state.dart';

class MoviedetailsCubit extends Cubit<MoviedetailsState> {
  final MovieRepository movieRepository;
  List<MovieDetailsModel> movieDetails = [];
  MoviedetailsCubit(this.movieRepository) : super(MoviedetailsInitial());

  List<MovieDetailsModel> getMoviesDetails(int movieId) {
    movieRepository.getMoviesDetails(movieId).then((movieDetails) {
      emit(MovieDetailsLoaded(movieDetails));
      this.movieDetails = movieDetails;
    });
    return movieDetails;
  }
}
