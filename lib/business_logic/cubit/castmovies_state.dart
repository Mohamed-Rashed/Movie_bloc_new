part of 'castmovies_cubit.dart';

@immutable
abstract class CastmoviesState {}

class CastmoviesInitial extends CastmoviesState {}
class CastLoaded extends CastmoviesState {
  final List<PopularMoviesModel> cast;

  CastLoaded(this.cast);
}