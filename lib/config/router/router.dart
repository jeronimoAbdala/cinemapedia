import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/' ,
  routes: [
    GoRoute(
      path: '/', 
  
      builder: (context, state) => const HomeScreen(),
      ),
    GoRoute(
      path: '/movie', 
  
      builder: (context, state) => const HomeScreen(),
      ),
  ]
  
  
);