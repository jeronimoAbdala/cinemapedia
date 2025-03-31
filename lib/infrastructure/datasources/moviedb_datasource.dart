

import 'package:cinemapedia/config/constant/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
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



}