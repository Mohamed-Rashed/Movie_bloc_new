import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/repository/movie_repo.dart';
import 'package:movie_app_blocd/presentation/screens/movie_details_screen.dart';
import 'package:movie_app_blocd/presentation/screens/movie_home.dart';

import 'business_logic/cubit/genres_cubit.dart';
import 'data/web_services/movie_web_service.dart';

class AppRouter {
  late MovieRepository moviesRepository;

  AppRouter() {
    moviesRepository = MovieRepository(MovieWebServices());
  }
  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreenRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GenresCubit(moviesRepository),
                    ),
                    BlocProvider(
                      create: (context) => PopularmoviesCubit(moviesRepository),
                    ),
                  ],
                  child: HomeScreen(),
                ));
      case movieDetailsRoute:
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen());
    }
  }
}
