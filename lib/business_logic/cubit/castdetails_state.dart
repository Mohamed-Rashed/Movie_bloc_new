part of 'castdetails_cubit.dart';

@immutable
abstract class CastdetailsState {}

class CastdetailsInitial extends CastdetailsState {}

class CastDetailsLoaded extends CastdetailsState {
  final List<CastDetailsModel> castDetails;

  CastDetailsLoaded(this.castDetails);
}