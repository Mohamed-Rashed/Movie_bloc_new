import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/genres_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'genres_state.dart';

class GenresCubit extends Cubit<GenresState> {
  final MovieRepository movieRepository;
  List<GenresModel> genres = [];

  GenresCubit(this.movieRepository) : super(GenresInitial());

  List<GenresModel> getAllGenres() {
    movieRepository.getAllGenres().then((genres) {
      emit(GenresLoaded(genres));
      this.genres = genres;
    });
    return genres;
  }
}
