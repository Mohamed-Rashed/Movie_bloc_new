import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'popularmovies_state.dart';

class PopularmoviesCubit extends Cubit<PopularmoviesState> {
  final MovieRepository movieRepository;
  List<PopularMoviesModel> popularMovies = [];
  List<PopularMoviesModel> searchedMovies = [];
  List<PopularMoviesModel> similarMovies = [];

  PopularmoviesCubit(this.movieRepository) : super(PopularmoviesInitial());

  List<PopularMoviesModel> getPopularMovies() {
    movieRepository.getPopularMovies().then((popularMovies) {
      emit(PopularMoviesLoaded(popularMovies));
      this.popularMovies = popularMovies;
    });
    return popularMovies;
  }

  List<PopularMoviesModel> getSearchedMovie(String searchName) {
    movieRepository.getSearchedMovie(searchName).then((searchedMovies) {
      emit(SearchedMoviesLoaded(searchedMovies));
      this.searchedMovies = searchedMovies;
    });
    return searchedMovies;
  }


  List<PopularMoviesModel> getSimilarMovies(int movieID) {
    movieRepository.getSimilarMovies(movieID).then((similarMovies) {
      emit(SimilarMoviesLoaded(similarMovies));
      this.similarMovies = similarMovies;
    });
    return similarMovies;
  }
}
