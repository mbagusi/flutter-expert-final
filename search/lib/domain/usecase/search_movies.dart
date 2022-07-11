import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class SearchMovie {
  final MovieRepository repository;

  SearchMovie(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
