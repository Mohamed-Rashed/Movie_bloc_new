import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_blocd/business_logic/cubit/popularmovies_cubit.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/artists_model.dart';
import 'package:movie_app_blocd/data/models/movie_characters.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget buildSearchField(BuildContext context, TextEditingController searchTextContrllor) {
  return TextField(
    controller: searchTextContrllor,
    cursorColor: MyColor.kgray,
    decoration: InputDecoration(
      hintText: "Search Movie ...",
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: MyColor.kgray,
        fontSize: 18,
      ),
    ),
    style: TextStyle(fontSize: 18, color: MyColor.kgray),
    onChanged: (searchedCharacter) {
      BlocProvider.of<PopularmoviesCubit>(context)
          .getSearchedMovie(searchedCharacter);
    },
  );
}


///////////////////////////////////////////////////////////////


Widget buildMoviesCharactersList(BuildContext context, List<Cast> cast) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 20, 8, 8),
    child: Column(
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, CastScreenRoute , arguments: cast[index]);
                      },
                      child: CachedNetworkImage(
                        imageUrl: "${imgUrl}${cast[index].profilePath}",
                        imageBuilder: (context, imageProvider) => Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset("assets/images/loading.gif"),
                        errorWidget: (context, url, error) => Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage("assets/images/img.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
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
                              cast[index].name,
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


///////////////////////////////////////////////////////////////


Widget buildArtistsList(BuildContext context, List<ArtitstsResults> results) {
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
              return results[index].knownForDepartment == "Acting" && results[index].profilePath != null ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ArtistScreenRoute , arguments: results[index]);
                      },
                      child: CachedNetworkImage(
                        imageUrl: "${imgUrl}${results[index].profilePath}",
                        imageBuilder: (context, imageProvider) => Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset("assets/images/loading.gif"),
                        errorWidget: (context, url, error) => Container(
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage("assets/images/img.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
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
                              results[index].name!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                ),
              ): Container();
            },
          ),
        )
      ],
    ),
  );
}


///////////////////////////////////////////////////////////////



openPopup(context, YoutubePlayerController controller) {
  Alert(
      closeFunction: (){
        Navigator.pop(context);
      },

      onWillPopActive: true,
      context: context,
      content: Container(
        height: MediaQuery.of(context).size.height/3,
        child: YoutubePlayer(
          controller: controller,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]
  ).show();
}

////////////////////////////////////////////////////////////////////


Widget buildSliverAppBar(String title, bool value, int id, String posterPath) {
  return SliverAppBar(
    expandedHeight: 600,
    pinned: true,
    stretch: true,
    backgroundColor: MyColor.kgray,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: MyColor.kwhite),
      ),
      background: Hero(
        tag: value
            ? "${id} ${value}"
            : id,
        child: CachedNetworkImage(
          imageUrl: "${imgUrl + posterPath}",
          placeholder: (context, url) =>  Image.asset("assets/images/loading.gif"),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////

 exitApp(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Exit"),
          content: Text("Are you sure you want to exit?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                exit(0);
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
  );
}
/////////////////////////////////////////////////////////

Widget buildNoInternetWidget() {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Can\'t connect .. check internet',
            style: TextStyle(
              fontSize: 22,
              color: MyColor.kgray,
            ),
          ),
          Image.asset('assets/images/error.png')
        ],
      ),
    ),
  );
}