import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  @override
  
    final ActorsDatasource datasource;
    ActorRepositoryImpl(this.datasource);

    @override
    Future<List<Actor>> getActorByMovie(String movieId){
      return datasource.getActorByMovie(movieId);
    }
  }
