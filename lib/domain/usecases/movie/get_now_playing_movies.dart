import 'package:dartz/dartz.dart';
import 'package:movie_propnext/common/failure.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/repositories/movie_repositories.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
