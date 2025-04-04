import 'package:cinemapedia/presentation/delegates/search_movies_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
   CustomAppBar({super.key});


  @override
  Widget build(BuildContext context, ref) {


  final colors = Theme.of(context).colorScheme;
  final titleStyle = Theme.of(context).textTheme.titleMedium;


    return SafeArea(
      bottom: false,
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(height: 10,),
            Icon(Icons.movie_outlined, color: colors.primary ,),
            const SizedBox(width: 5,),
            Text('cinemapedua', style:titleStyle ,),
            const Spacer(),

            IconButton(onPressed: (){

              final movieRepository = ref.read(movieRepositoryProvider);

              showSearch(
                context: context, 
                delegate: SearchMoviesDelegate(
                  searchMovies: movieRepository.searchMovies,
                ),
                ).then((movie){
                if(movie != null){
                   context.push('movie/${movie.id}');

                }

                });
                

            }, icon: Icon(Icons.search))
          ],
        ),
      ),),
    );
  }
}