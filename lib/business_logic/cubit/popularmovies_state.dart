part of 'popularmovies_cubit.dart';

@immutable
abstract class PopularmoviesState {}

class PopularmoviesInitial extends PopularmoviesState {}

class PopularMoviesLoaded extends PopularmoviesState {
  final List<PopularMoviesModel> popularMovies;

  PopularMoviesLoaded(this.popularMovies);
}
