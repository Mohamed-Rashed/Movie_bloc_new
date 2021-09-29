import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'moviesbygenres_state.dart';

class MoviesbygenresCubit extends Cubit<MoviesbygenresState> {
  final MovieRepository movieRepository;
  List<PopularMoviesModel> moviesbyGenres = [];

  MoviesbygenresCubit(this.movieRepository) : super(MoviesbygenresInitial());

  List<PopularMoviesModel> getMoviesbyGenres(int genresID) {
    movieRepository.getMoviesbyGenres(genresID).then((moviesbyGenres) {
      emit(MoviesbygenresLoaded(moviesbyGenres));
      this.moviesbyGenres = moviesbyGenres;
    });
    return moviesbyGenres;
  }
}
