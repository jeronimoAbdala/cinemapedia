

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity( MovieMovieDB moviedb) => Movie(
  adult: moviedb.adult , 
  backdropPath: moviedb.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg', 
  genreIds: moviedb.genreIds.map((e)=> e.toString()).toList(), 
  id: moviedb.id, 
  originalLanguage: moviedb.originalLanguage, 
  originalTitle: moviedb.originalTitle, 
  overview: moviedb.overview, 
  popularity: moviedb.popularity, 
  posterPath: (moviedb.posterPath != '') ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg', 
  releaseDate: moviedb.releaseDate, 
  title: moviedb.title, 
  video: moviedb.video, 
  voteAverage: moviedb.voteAverage, 
  voteCount: moviedb.voteCount);


  static Movie movieDetailsToEntity( MovieDetails movie) => Movie(
    adult: movie.adult , 
  backdropPath: movie.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}' : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg', 
  genreIds: movie.genres.map((e)=> e.name ).toList(), 
  id: movie.id, 
  originalLanguage: movie.originalLanguage, 
  originalTitle: movie.originalTitle, 
  overview: movie.overview, 
  popularity: movie.popularity, 
  posterPath: (movie.posterPath != '') ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}' : 'https://img.freepik.com/vector-gratis/poster-error-404-pagina-no-encontrada-usar-sitio-web_1284-49337.jpg', 
  releaseDate: movie.releaseDate, 
  title: movie.title, 
  video: movie.video, 
  voteAverage: movie.voteAverage, 
  voteCount: movie.voteCount);



}