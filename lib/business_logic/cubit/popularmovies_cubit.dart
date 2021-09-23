import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'popularmovies_state.dart';

class PopularmoviesCubit extends Cubit<PopularmoviesState> {
  final MovieRepository movieRepository;
  List<PopularMoviesModel> popularMovies = [];

  PopularmoviesCubit(this.movieRepository) : super(PopularmoviesInitial());

  List<PopularMoviesModel> getPopularMovies() {
    movieRepository.getPopularMovies().then((popularMovies) {
      emit(PopularMoviesLoaded(popularMovies));
      this.popularMovies = popularMovies;
    });
    return popularMovies;
  }
}
