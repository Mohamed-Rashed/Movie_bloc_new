import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_blocd/ads_manager.dart';
import 'package:movie_app_blocd/business_logic/cubit/artitstssearch_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/genres_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/moviesbygenres_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/data/models/artists_model.dart';
import 'package:movie_app_blocd/data/models/genres_model.dart';
import 'package:movie_app_blocd/data/models/hero_tag.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/presentation/widget/ads_widget.dart';
import 'package:movie_app_blocd/presentation/widget/movie_item.dart';
import 'package:movie_app_blocd/presentation/widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AdmobBannerSize bannerSize;
  late AdmobInterstitial interstitialAd;

  List<GenresModel>? allGenres;
  List<PopularMoviesModel>? popularMovies;
  List<PopularMoviesModel>? searchedMovies;
  List<PopularMoviesModel>? moviesbyGenres;
  List<ArtitstsModel>? artitsts;
  int genresID = 28;
  DateTime pre_backpress = DateTime.now();
  String genresname = "Action";
  bool _isSearching = false;
  HeroTag heroTag = GetIt.instance.get<HeroTag>();
  final _searchTextContrllor = TextEditingController();
  final _searchArtistsTextContrllor = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GenresCubit>(context).getAllGenres();
    BlocProvider.of<PopularmoviesCubit>(context).getPopularMovies();
    BlocProvider.of<MoviesbygenresCubit>(context).getMoviesbyGenres(genresID);
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    _searchTextContrllor.dispose();
    _searchArtistsTextContrllor.dispose();
    super.dispose();
  }

  Widget buildPopularMoviesList(List<Results> results, bool isfirstList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 8, 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isfirstList
                  ? _searchTextContrllor.text.isNotEmpty
                      ? "Searched Movies :-"
                      : "Popular Movies :-"
                  : "${genresname} Movies",
              style: TextStyle(
                color: MyColor.kwhite,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: results.length == 0
                ? Column(
                    children: [
                      Image.asset('assets/images/sorry.gif'),
                      Text(
                        "sorry no results found :(",
                        style: TextStyle(color: MyColor.kwhite, fontSize: 18),
                      )
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                        child: results[index].posterPath != null
                            ? MovieItem(
                                interstitialAd: interstitialAd,
                                isfirstList: isfirstList,
                                movie: results[index],
                              )
                            : Container(),
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
                BlocProvider.of<MoviesbygenresCubit>(context)
                    .getMoviesbyGenres(genresID);
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

  void _clearSearch() {
    setState(() {
      _searchTextContrllor.clear();
    });
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            BlocProvider.of<PopularmoviesCubit>(context).getPopularMovies();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColor.kgray),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColor.kgray,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    BlocProvider.of<PopularmoviesCubit>(context).getPopularMovies();
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return Scaffold(
            backgroundColor: MyColor.kgray,
            appBar: AppBar(
              title: _isSearching
                  ? buildSearchField(context, _searchTextContrllor)
                  : Text(
                      'TzKarty',
                      style: TextStyle(color: MyColor.kgray, fontSize: 25),
                    ),
              centerTitle: true,
              toolbarHeight: 100,
              backgroundColor: MyColor.kyellow,
              actions: _buildAppBarActions(),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        BlocBuilder<PopularmoviesCubit, PopularmoviesState>(
                          builder: (context, state) {
                            if (state is PopularMoviesLoaded) {
                              popularMovies = (state).popularMovies;
                              return buildPopularMoviesList(
                                  popularMovies![0].results, true);
                            }
                            if (_searchTextContrllor.text.isNotEmpty &&
                                state is SearchedMoviesLoaded) {
                              searchedMovies = (state).searchedMovies;
                              return buildPopularMoviesList(
                                  searchedMovies![0].results, true);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          child: ListTile(
                            leading: Icon(Icons.search,color: MyColor.kwhite,),
                            title: TextField(
                              controller: _searchArtistsTextContrllor,
                              cursorColor: MyColor.kwhite,
                              decoration: InputDecoration(
                                hintText: "Search Artists ...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: MyColor.kwhite,
                                  fontSize: 18,
                                ),
                              ),
                              style: TextStyle(fontSize: 18, color: MyColor.kwhite),
                              onSubmitted: (searchedArtists) {
                                BlocProvider.of<ArtitstssearchCubit>(context)
                                    .getArtistsSearch(searchedArtists);
                              },

                            ),
                          ),
                        ),
                        Visibility(
                          visible: _searchArtistsTextContrllor.text.isNotEmpty,
                          child: BlocBuilder<ArtitstssearchCubit, ArtitstssearchState>(
                            builder: (context, state) {
                              if (state is ArtitstssearchLoaded) {
                                artitsts = (state).artitsts;
                                return Column(
                                  children: [
                                    artitsts!.length > 0 ? buildArtistsList(
                                        context, artitsts![0].results) : Container(),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
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
                              return buildPopularMoviesList(
                                  moviesbyGenres![0].results, false);
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
        } else {
          return Scaffold(
            backgroundColor: MyColor.kwhite,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "TzKarty",
                style: TextStyle(color: MyColor.kgray, fontSize: 25),
              ),
              backgroundColor: MyColor.kyellow,
            ),
            body: buildNoInternetWidget(),
          );
        }
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
