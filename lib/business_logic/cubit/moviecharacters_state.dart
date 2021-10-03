part of 'moviecharacters_cubit.dart';

@immutable
abstract class MoviecharactersState {}

class MoviecharactersInitial extends MoviecharactersState {}
class MovieCharactersLoaded extends MoviecharactersState {
  final List<MovieCharacters> movieCharacters;

  MovieCharactersLoaded(this.movieCharacters);
}