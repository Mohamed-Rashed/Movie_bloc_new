import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'castmovies_state.dart';

class CastmoviesCubit extends Cubit<CastmoviesState> {
  final MovieRepository movieRepository;
  List<PopularMoviesModel> cast = [];
  CastmoviesCubit(this.movieRepository) : super(CastmoviesInitial());

  List<PopularMoviesModel> getCastMovies(int castID) {
    movieRepository.getCastMovies(castID).then((cast) {
      emit(CastLoaded(cast));
      this.cast = cast;
    });
    return cast;
  }


}
