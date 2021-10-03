import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_blocd/business_logic/cubit/genres_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviesbygenres_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/data/models/genres_model.dart';
import 'package:movie_app_blocd/data/models/hero_tag.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/presentation/widget/movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}  

class _HomeScreenState extends State<HomeScreen> {
  List<GenresModel>? allGenres;
  List<PopularMoviesModel>? popularMovies;
  List<PopularMoviesModel>? moviesbyGenres;
  int genresID = 28;
  String genresname = "Action";
  HeroTag heroTag = GetIt.instance.get<HeroTag>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GenresCubit>(context).getAllGenres();
    BlocProvider.of<PopularmoviesCubit>(context).getPopularMovies();
    BlocProvider.of<MoviesbygenresCubit>(context).getMoviesbyGenres(genresID);
  }

  Widget buildPopularMoviesList(List<Results> results, bool isfirstList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 8, 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isfirstList ? "Popular Movies :-" : "${genresname} Movies",
              style: TextStyle(
                color: MyColor.kwhite,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                  child: MovieItem(
                    isfirstList : isfirstList,
                    movie: results[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildGenresList(List<Genres> genres) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  genresID = genres[index].id;
                  genresname = genres[index].name;
                });
                BlocProvider.of<MoviesbygenresCubit>(context).getMoviesbyGenres(genresID);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: MyColor.kyellow,
                      border: Border.all(
                        color: MyColor.kblack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      genres[index].name,
                      style: TextStyle(color: MyColor.kwhite, fontSize: 15),
                    ),
                  ))),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.kgray,
      appBar: AppBar(
        title: Text('Movies'),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: MyColor.kyellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<PopularmoviesCubit, PopularmoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoaded) {
                  popularMovies = (state).popularMovies;
                  return buildPopularMoviesList(popularMovies![0].results,true);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            BlocBuilder<GenresCubit, GenresState>(
              builder: (context, state) {
                if (state is GenresLoaded) {
                  allGenres = (state).genres;
                  return buildGenresList(allGenres![0].genres);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            BlocBuilder<MoviesbygenresCubit, MoviesbygenresState>(
              builder: (context, state) {
                if (state is MoviesbygenresLoaded) {
                  moviesbyGenres = (state).moviesbyGenres;
                  return buildPopularMoviesList(moviesbyGenres![0].results,false);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
