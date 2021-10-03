

import 'package:get_it/get_it.dart';
import 'package:movie_app_blocd/data/models/hero_tag.dart';

final GetIt getIt = GetIt.instance;

void setup(){
  getIt.registerLazySingleton(() => HeroTag());
}