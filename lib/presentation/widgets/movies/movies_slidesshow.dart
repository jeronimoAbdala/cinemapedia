import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MoviesSlidesshow extends StatelessWidget {

  final List<Movie> movies;
  
  const MoviesSlidesshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,

        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 10),
          builder: DotSwiperPaginationBuilder(
            activeColor: color.primary,
            color: color.tertiary
          )
        ),

        itemCount:movies.length,
        itemBuilder: (context, index){

          return _Slide(movie: movies[index]);
        },
        
        ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

   _Slide({ required this.movie});

  final decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 10)
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration:decoration ,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress){
              if( loadingProgress != null){
                return const DecoratedBox(decoration: BoxDecoration(color: Colors.black12));
              }

              return FadeIn(child:child);
            },
          ),
          
          
          )
       
    ));
  }
}