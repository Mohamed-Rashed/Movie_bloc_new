part of 'popularmovies_cubit.dart';

@immutable
abstract class PopularmoviesState {}

class PopularmoviesInitial extends PopularmoviesState {}

class PopularMoviesLoaded extends PopularmoviesState {
  final List<PopularMoviesModel> popularMovies;

  PopularMoviesLoaded(this.popularMovies);
}

class SearchedMoviesLoaded extends PopularmoviesState {
  final List<PopularMoviesModel> searchedMovies;

  SearchedMoviesLoaded(this.searchedMovies);
}

class SimilarMoviesLoaded extends PopularmoviesState {
  final List<PopularMoviesModel> similarMovies;

  SimilarMoviesLoaded(this.similarMovies);
}
