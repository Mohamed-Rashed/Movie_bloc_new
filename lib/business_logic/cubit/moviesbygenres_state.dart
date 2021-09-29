part of 'moviesbygenres_cubit.dart';

@immutable
abstract class MoviesbygenresState {}

class MoviesbygenresInitial extends MoviesbygenresState {}

class MoviesbygenresLoaded extends MoviesbygenresState {
  final List<PopularMoviesModel> moviesbyGenres;

  MoviesbygenresLoaded(this.moviesbyGenres);
}
