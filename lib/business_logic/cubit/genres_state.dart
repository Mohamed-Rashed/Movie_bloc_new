part of 'genres_cubit.dart';

@immutable
abstract class GenresState {}

class GenresInitial extends GenresState {}

class GenresLoaded extends GenresState {
  final List<GenresModel> genres;

  GenresLoaded(this.genres);
}
