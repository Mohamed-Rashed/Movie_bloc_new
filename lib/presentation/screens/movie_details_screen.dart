import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviedetails_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/movie_details_model.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Results movie;
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<MovieDetailsModel>? movieDetails;

  @override
  void initState() {
    BlocProvider.of<MoviedetailsCubit>(context).getMoviesDetails(550988);
    super.initState();
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.kgray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.movie.title,
          style: TextStyle(color: MyColor.kwhite),
        ),
        background: Hero(
          tag: widget.movie.id,
          child: Image.network(
            "${imgUrl + widget.movie.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.kgray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 500,
                  )
                ]
            ),
          )
        ],
      ),
    );
  }
}
