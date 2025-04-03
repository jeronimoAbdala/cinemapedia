import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query) ;

class SearchMoviesDelegate extends SearchDelegate {


  final SearchMoviesCallback searchMovies ;

  SearchMoviesDelegate({
    required this.searchMovies
  });

  

  @override
  String get searchFieldLabel => 'Buscar peli';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
        onPressed: ()=> query = '', 
        icon: const Icon(Icons.clear)),
      )
    ];
  } 

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: ()=> close(context, null), icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
    future: searchMovies(query), 
    initialData: const [],
    builder: (context,snapshot){
      final movies = snapshot.data ?? [];

      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieItem(movie:movie, onMovieSelected: ()=>'dsa',);

        },
      );
    });
  }


}

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( 
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10),
            
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( movie.title, style: textStyles.titleMedium ),
    
                  ( movie.overview.length > 100 )
                    ? Text( '${movie.overview.substring(0,100)}...' )
                    : Text( movie.overview ),
    
                  Row(
                    children: [
                      Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                      const SizedBox(width: 5),
                      
                    ],
                  )
    
                  
                ],
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}