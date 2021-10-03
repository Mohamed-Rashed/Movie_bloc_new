part of 'movievideos_cubit.dart';

@immutable
abstract class MovievideosState {}

class MovievideosInitial extends MovievideosState {}
class MovieVideosLoaded extends MovievideosState {
  final List<MovieVideosModel> movieVideos;

  MovieVideosLoaded(this.movieVideos);
}