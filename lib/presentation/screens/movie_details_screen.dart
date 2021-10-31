import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_blocd/ads_manager.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviecharacters_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviedetails_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/movievideos_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/hero_tag.dart';
import 'package:movie_app_blocd/data/models/movie_characters.dart';
import 'package:movie_app_blocd/data/models/movie_details_model.dart';
import 'package:movie_app_blocd/data/models/movie_videos_model.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/presentation/widget/ads_widget.dart';
import 'package:movie_app_blocd/presentation/widget/movie_item.dart';
import 'package:movie_app_blocd/presentation/widget/widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Results movie;
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late YoutubePlayerController _controller;
  List<MovieDetailsModel>? movieDetails;
  List<PopularMoviesModel>? similarMovies;
  List<MovieCharacters>? movieCharacters;
  List<MovieVideosModel>? movieVideos;
  late AdmobInterstitial interstitialAd;
  HeroTag heroTag = GetIt.instance.get<HeroTag>();
  @override
  void initState() {
    BlocProvider.of<MoviedetailsCubit>(context)
        .getMoviesDetails(widget.movie.id!);
    BlocProvider.of<MoviecharactersCubit>(context)
        .getMoviesCharacters(widget.movie.id!);
    BlocProvider.of<MovievideosCubit>(context)
        .getMoviesVideos(widget.movie.id!);
    BlocProvider.of<PopularmoviesCubit>(context)
        .getSimilarMovies(widget.movie.id!);
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          );
        },
      ),
    );
  }

  Widget buildMoviesCompaniesList(
      List<ProductionCompanies> productionCompanies, String posterPath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 8, 8),
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productionCompanies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: productionCompanies[index].logoPath != null
                                  ? NetworkImage(
                                      "${imgUrl}${productionCompanies[index].logoPath}",
                                    )
                                  : NetworkImage("${imgUrl}${posterPath}"),
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Center(
                              child: Text(
                            productionCompanies[index].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildMoviesVideosList(List<MovieResults> results) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 8, 8),
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (context, index) {
                return results[index].site == "YouTube"
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                        child: InkWell(
                          onTap: () {
                            _controller = YoutubePlayerController(
                              initialVideoId: "${results[index].key}",
                              flags: const YoutubePlayerFlags(
                                mute: false,
                                autoPlay: true,
                                disableDragSeek: false,
                                loop: false,
                                isLive: false,
                                forceHD: false,
                                enableCaption: true,
                              ),
                            );
                            openPopup(context, _controller);
                          },
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    "${imgUrl + widget.movie.posterPath!}",
                                  ),
                                )),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.kgray,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              buildSliverAppBar(widget.movie.title!, heroTag.value,
                  widget.movie.id!, widget.movie.posterPath!),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 14, 5, 0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Vote Rating *",
                          style: TextStyle(
                              color: MyColor.kyellow,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.movie.voteAverage}",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<MoviedetailsCubit, MoviedetailsState>(
                          builder: (context, state) {
                            if (state is MovieDetailsLoaded) {
                              movieDetails = (state).movieDetails;
                              return buildGenresList(movieDetails![0].genres);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "overview :-",
                            style: TextStyle(
                                color: MyColor.kyellow,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.movie.overview}",
                          style: TextStyle(
                              color: MyColor.kwhite,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<MoviecharactersCubit, MoviecharactersState>(
                          builder: (context, state) {
                            if (state is MovieCharactersLoaded) {
                              movieCharacters = (state).movieCharacters;
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "cast :-",
                                      style: TextStyle(
                                          color: MyColor.kyellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildMoviesCharactersList(
                                      context, movieCharacters![0].cast),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<MovievideosCubit, MovievideosState>(
                          builder: (context, state) {
                            if (state is MovieVideosLoaded) {
                              movieVideos = (state).movieVideos;
                              return Visibility(
                                visible: movieVideos![0].results.length > 0,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Movie Videos :-",
                                        style: TextStyle(
                                            color: MyColor.kyellow,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    buildMoviesVideosList(
                                        movieVideos![0].results),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<MoviedetailsCubit, MoviedetailsState>(
                          builder: (context, state) {
                            if (state is MovieDetailsLoaded) {
                              movieDetails = (state).movieDetails;
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Release Date :-",
                                      style: TextStyle(
                                          color: MyColor.kyellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${movieDetails![0].releaseDate}",
                                    style: TextStyle(
                                        color: MyColor.kwhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Production Companies :-",
                                      style: TextStyle(
                                          color: MyColor.kyellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buildMoviesCompaniesList(
                                      movieDetails![0].productionCompanies,
                                      widget.movie.posterPath!),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<PopularmoviesCubit, PopularmoviesState>(
                          builder: (context, state) {
                            if (state is SimilarMoviesLoaded) {
                              similarMovies = (state).similarMovies;
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Similar Movies :-",
                                      style: TextStyle(
                                          color: MyColor.kyellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          similarMovies![0].results.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 4, 8),
                                          child: similarMovies![0]
                                                      .results[index]
                                                      .posterPath !=
                                                  null
                                              ? MovieItem(
                                                  interstitialAd:
                                                      interstitialAd,
                                                  isfirstList: true,
                                                  movie: similarMovies![0]
                                                      .results[index],
                                                )
                                              : Container(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
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
                  SizedBox(
                    height: 500,
                  )
                ]),
              )
            ],
          ),
          Positioned(
            child: bannerAd(),
            bottom: 2,
            left: 2,
            right: 2,
          )
        ],
      ),
    );
  }
}
