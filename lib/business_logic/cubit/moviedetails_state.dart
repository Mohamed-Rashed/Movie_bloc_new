part of 'moviedetails_cubit.dart';

@immutable
abstract class MoviedetailsState {}

class MoviedetailsInitial extends MoviedetailsState {}

class MovieDetailsLoaded extends MoviedetailsState {
  final List<MovieDetailsModel> movieDetails;

  MovieDetailsLoaded(this.movieDetails);
}