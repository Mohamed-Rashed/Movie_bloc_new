import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_blocd/constant/myColor.dart';
import 'package:movie_app_blocd/constant/strings.dart';
import 'package:movie_app_blocd/data/models/hero_tag.dart';
import 'package:movie_app_blocd/data/models/popularMovies_model.dart';

class MovieItem extends StatelessWidget {
  final Results movie;
  bool isfirstList;
  HeroTag heroTag = GetIt.instance.get<HeroTag>();

  MovieItem({Key? key, required this.movie,required this.isfirstList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      child: InkWell(
        onTap: (){
          if(isfirstList){
            heroTag.value = isfirstList;
          }
          else{
            heroTag.value = false;
          }
          Navigator.pushNamed(context, movieDetailsRoute, arguments: movie);
        },
        child: Stack(
          children: [
            Hero(
              tag: isfirstList ? movie.id : "${movie.id} genre}",
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        "${imgUrl + movie.posterPath}",
                      ),
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Center(child: Text(movie.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
