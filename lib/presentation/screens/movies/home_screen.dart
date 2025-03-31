import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomeView(),
        bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<_HomeView> {

  @override
void initState() {
  super.initState();
  Future.microtask(() {
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
   
  });
}


  @override
Widget build(BuildContext context) {
  // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  final slidesShowMovies = ref.watch(moviesSlideShowProvider);
  final popularMovies = ref.watch(popularMoviesProvider);
  final topRatedMovies = ref.watch(topRatedMoviesProvider);

  
  
  return CustomScrollView(
    slivers:[

       SliverAppBar(
        floating: true,
     
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),

      SliverList(delegate: SliverChildBuilderDelegate((context, index) {
        
        return Column(
      children: [
        CustomAppBar(),
    
        MoviesSlidesshow(movies: slidesShowMovies),
    
        MovieHorizontalListview(
          label: 'En Cines',
          sublabel: 'Lunes 20',
          movies: nowPlayingMovies,
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
          ,
          ),
        MovieHorizontalListview(
          label: 'Populares',
          sublabel: '',
          movies: popularMovies,
          loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
          ,
          ),
        MovieHorizontalListview(
          label: 'En Cines',
          sublabel: 'Lunes 20',
          movies: topRatedMovies,
          loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
          ,
          ),
        MovieHorizontalListview(
          label: 'En Cines',
          sublabel: 'Lunes 20',
          movies: nowPlayingMovies,
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
          ,
          ),

          SizedBox(height: 50,)
    
    
    
    
    
    
    
    
        // Expanded(
        //   child: ListView.builder(
        //       itemCount: nowPlayingMovies.length,
        //       itemBuilder: (context, index) {
        //   final movie = nowPlayingMovies[index];
        //   return ListTile(
        //     title: Text(movie.title),
        //   );
        //       },
        //     ),
        // ),
      ],
    );
      },
      childCount: 1
      ))
    ]
    
    
     
  );
}
}