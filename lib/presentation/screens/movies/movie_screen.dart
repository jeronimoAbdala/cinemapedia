import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movieScreen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }




  @override
  Widget build(BuildContext context) {

    //declaramos el mappeo de la peli 
    final Movie? movie = ref.watch( movieInfoProvider )[widget.movieId];

    if(movie == null){
      return Scaffold(body: const Center(child: CircularProgressIndicator(strokeWidth: 2,),));
    }
    

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => MovieDetails(movie: movie,),
            childCount: 1
          ))


        ],
      ),
    );
  }
}
class MovieDetails extends StatelessWidget {
  final Movie movie;
  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textstyles = Theme.of(context).textTheme;



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(9)),
        Placeholder()
      ],
    );
  }
}




class _CustomSliverAppbar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppbar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: 
          Text(movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign:TextAlign.center,

        ),

        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover,),
            ),

            const SizedBox.expand(
              child: DecoratedBox(decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7,1.0],
                  colors: [Colors.transparent, Colors.black54])
              )),
            ),
            const SizedBox.expand(
              child: DecoratedBox(decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0,0.4],
                  colors: [Colors.black54, Colors.transparent])
              )),
            )
          ],
        ),

      ),
    );
  }
}