import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_blocd/ads_manager.dart';
import 'package:movie_app_blocd/business_logic/cubit/castdetails_cubit.dart';
import 'package:movie_app_blocd/business_logic/cubit/castmovies_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/cast_details_model.dart';
import 'package:movie_app_blocd/data/models/movie_characters.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';
import 'package:movie_app_blocd/presentation/widget/ads_widget.dart';
import 'package:movie_app_blocd/presentation/widget/movie_item.dart';

class CastMovies extends StatefulWidget {
  Cast cast;

  CastMovies({Key? key, required this.cast}) : super(key: key);

  @override
  _CastMoviesState createState() => _CastMoviesState();
}

class _CastMoviesState extends State<CastMovies> {
  List<CastDetailsModel>? castDetails;
  List<PopularMoviesModel>? castVideos;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    BlocProvider.of<CastmoviesCubit>(context).getCastMovies(widget.cast.id);
    BlocProvider.of<CastdetailsCubit>(context).getCastDetails(widget.cast.id);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 500,
                pinned: true,
                stretch: true,
                backgroundColor: MyColor.kgray,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    widget.cast.name,
                    style: TextStyle(color: MyColor.kwhite),
                  ),
                  background: CachedNetworkImage(
                    imageUrl: "${imgUrl + widget.cast.profilePath!}",
                    placeholder: (context, url) =>
                        Image.asset("assets/images/loading.gif"),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<CastdetailsCubit, CastdetailsState>(
                          builder: (context, state) {
                            if (state is CastDetailsLoaded) {
                              castDetails = (state).castDetails;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("${castDetails![0].biography}",
                                      style: TextStyle(
                                          color: Colors.grey, height: 1.4)),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Born",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${castDetails![0].birthday}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Nationality",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${castDetails![0].placeOfBirth}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20,
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
                        BlocBuilder<CastmoviesCubit, CastmoviesState>(
                          builder: (context, state) {
                            if (state is CastLoaded) {
                              castVideos = (state).cast;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Movies",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: castVideos![0].results.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 4, 8),
                                          child: castVideos![0]
                                              .results[index]
                                              .posterPath !=
                                              null
                                              ? MovieItem(
                                            interstitialAd: interstitialAd,
                                            isfirstList: true,
                                            movie: castVideos![0]
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
