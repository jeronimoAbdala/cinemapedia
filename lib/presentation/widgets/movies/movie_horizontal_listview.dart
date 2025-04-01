import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? label;
  final String? sublabel;
  final VoidCallback? loadNextPage;

  
  const MovieHorizontalListview({super.key, required this.movies, this.label, this.sublabel, this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {


  final scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    scrollController.addListener((){
      if (widget.loadNextPage == null ) return;

      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        print('loading next movie');

        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.label != null || widget.sublabel != null)
          _Tile(label: widget.label,sublabel: widget.sublabel,),

          Expanded(child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _Slide(movie: widget.movies[index]);
              
            },
          ))
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {
  final Movie movie; 
  
   _Slide({super.key, required this.movie});

  @override
  
  Widget build(BuildContext context) {


  final stylesmovies = Theme.of(context).textTheme;


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //imagen
          SizedBox(
          
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(

                movie.posterPath,
                height: 190,
                fit: BoxFit.cover,
           
                width: 150,
                loadingBuilder:  (context, child, loadingProgress) {
                  if (loadingProgress != null){ 
                    return const Padding(padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2,)),
                    );
                    
                    }
                

                  return GestureDetector(
                    onTap:()=> context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child)
                  );


                  
                },
              ),
            ),
          ),

          const SizedBox(height: 5,),
           SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2,style: stylesmovies.titleMedium),
            
            ),

            Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                Text('${movie.voteAverage}', style: stylesmovies.bodyMedium?.copyWith(color: Colors.yellow.shade800),  ),
                const SizedBox(width: 10),
                Text( HumanFormat.number(movie.popularity), style: stylesmovies.bodySmall?.copyWith(color: Colors.black),  ),
                const SizedBox(width: 10),
                
              ],
            )
        ],
      ),
    );
  }
}


class _Tile extends StatelessWidget {
  final String? label;
  final String? sublabel;

  const _Tile({ this.label, this.sublabel});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (label != null)
          Text(label!, style: titleStyle,),

          const Spacer(),

          if (sublabel != null)
          FilledButton.tonal(
            onPressed: () {
              
            },
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            child:Text(sublabel!)
            ),
        ],
      ),
    );
  }
}