import 'package:dartz/dartz.dart';
import 'package:movie_propnext/common/failure.dart';
import 'package:movie_propnext/domain/entities/movies/movie_detail.dart';
import 'package:movie_propnext/domain/repositories/movie_repositories.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
