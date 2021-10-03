import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/movie_characters.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'moviecharacters_state.dart';

class MoviecharactersCubit extends Cubit<MoviecharactersState> {
  final MovieRepository movieRepository;
  List<MovieCharacters> movieCharacters = [];
  MoviecharactersCubit(this.movieRepository) : super(MoviecharactersInitial());

  List<MovieCharacters> getMoviesCharacters(int movieId) {
    movieRepository.getMoviesCharacters(movieId).then((movieCharacters) {
      emit(MovieCharactersLoaded(movieCharacters));
      this.movieCharacters = movieCharacters;
    });
    return movieCharacters;
  }
}
