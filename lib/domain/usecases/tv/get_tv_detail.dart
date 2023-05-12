import 'package:dartz/dartz.dart';
import 'package:movie_propnext/common/failure.dart';
import 'package:movie_propnext/domain/entities/tv/tv_detail.dart';
import 'package:movie_propnext/domain/repositories/tv_repositories.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
