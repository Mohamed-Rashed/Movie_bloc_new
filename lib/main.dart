import 'package:flutter/material.dart';
import 'package:movie_app_blocd/app_route.dart';
import 'package:movie_app_blocd/service_locator.dart';

void main() {
  setup();
  runApp(MoviesApp(appRouter: AppRouter(),));
}

class MoviesApp extends StatelessWidget {
  final AppRouter appRouter;

  MoviesApp({required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.genrateRoute,
    );
  }
}