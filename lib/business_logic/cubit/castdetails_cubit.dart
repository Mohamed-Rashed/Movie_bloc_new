import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_blocd/data/models/cast_details_model.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';

part 'castdetails_state.dart';

class CastdetailsCubit extends Cubit<CastdetailsState> {
  final MovieRepository movieRepository;
  List<CastDetailsModel> castdetails = [];
  CastdetailsCubit(this.movieRepository) : super(CastdetailsInitial());

  List<CastDetailsModel> getCastDetails(int castID) {
    movieRepository.getCastDetails(castID).then((castdetails) {
      emit(CastDetailsLoaded(castdetails));
      this.castdetails = castdetails;
    });
    return castdetails;
  }
}
