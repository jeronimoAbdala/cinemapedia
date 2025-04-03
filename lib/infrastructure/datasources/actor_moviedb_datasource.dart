import 'package:cinemapedia/config/constant/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3/movie/', 
      queryParameters: { 'api_key' : Environment.movieDbKey} ),
    

      );
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get(
      '${movieId}/credits'
    );
   final actorResponse = CreditsResponse.fromJson(response.data);

   final List<Actor> actores = actorResponse.cast.map(
    (cast)=> ActorMapper.castToEntity(cast)
     ).toList();

    return actores;
  }
}