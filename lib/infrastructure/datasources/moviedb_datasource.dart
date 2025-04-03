

import 'package:cinemapedia/config/constant/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',

        queryParameters: {
          'api_key' : Environment.movieDbKey,
          'lenguage': 'es-MX'
        }
      )
    );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
    queryParameters: {
      'page' : page
    });

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results.map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    // Con | response | hacemos la peticion a la API-
    // en movieDbResponse recibimos esa respuesta en formato JSON
    // y luego mapeamos ese JSon para aplicarlo a nuestra estructura en esa ultima linea. devolvemos el json mapeado en movies


    return movies;

  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', 
    queryParameters: {
      'page' : page
    });

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results.map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', 
    queryParameters: {
      'page' : page
    });

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results.map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<Movie> getMovieById(String id)async {
    //Vamos a trabajar con el nuevo metodo para obtener una peli por el id.

    // Primero con dio mandamoos la peticion para obtener los datos de la peli con el id
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Not found');
    //Si no la encontramos poner not found

    //Vamos a crear un nuevo modelo el cual tendra toda la estuctura de la peticion http a la api themoviedb
    final movieDetails = MovieDetails.fromJson(response.data);

    //A esta peticion la vamos a pasar por un mapper para poder utilizar cada campo como una entidad.
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    //Retornamos esta entidad
    return movie;

  }


}