import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetPopularMovie {
  final MovieRepository repository;

  GetPopularMovie(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
