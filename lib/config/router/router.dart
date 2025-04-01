import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/' ,
  routes: [
    GoRoute(
      path: '/', 
      builder: (context, state) => const HomeScreen(),
      routes: [

         GoRoute(
          path: 'movie/:id', 
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
            
            }
            
            ,
          ),

      ]
      ),
   
  ]
  
  
);