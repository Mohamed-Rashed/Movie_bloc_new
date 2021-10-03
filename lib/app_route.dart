import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviecharacters_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviedetails_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviesbygenres_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/movievideos_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
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
                    BlocProvider(
                      create: (context) =>
                          MoviesbygenresCubit(moviesRepository),
                    ),
                  ],
                  child: HomeScreen(),
                ));
      case movieDetailsRoute:
        final movie = settings.arguments as Results;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => MoviedetailsCubit(moviesRepository),
                ),
                BlocProvider(
                  create: (context) => MoviecharactersCubit(moviesRepository),
                ),
                BlocProvider(
                  create: (context) => MovievideosCubit(moviesRepository),
                ),
              ],
              child: MovieDetailsScreen(movie: movie),
            ));
    }
  }
}
