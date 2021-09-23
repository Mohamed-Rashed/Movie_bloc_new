import 'package:flutter/material.dart';
import 'package:movie_app_blocd/app_route.dart';

void main() {
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