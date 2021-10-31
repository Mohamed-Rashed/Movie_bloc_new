import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/artists_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'artitstssearch_state.dart';

class ArtitstssearchCubit extends Cubit<ArtitstssearchState> {
  final MovieRepository movieRepository;
  List<ArtitstsModel> artist = [];
  ArtitstssearchCubit(this.movieRepository) : super(ArtitstssearchInitial());

  List<ArtitstsModel> getArtistsSearch(String artistName) {
    movieRepository.getArtistsSearch(artistName).then((artist) {
      emit(ArtitstssearchLoaded(artist));
      this.artist = artist;
    });
    return artist;
  }
}
