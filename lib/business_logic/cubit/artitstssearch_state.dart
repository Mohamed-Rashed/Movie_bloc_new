part of 'artitstssearch_cubit.dart';

@immutable
abstract class ArtitstssearchState {}

class ArtitstssearchInitial extends ArtitstssearchState {}
class ArtitstssearchLoaded extends ArtitstssearchState {
  final List<ArtitstsModel> artitsts;

  ArtitstssearchLoaded(this.artitsts);
}