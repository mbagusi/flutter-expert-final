import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovie searchMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchMovie = SearchMovie(mockMovieRepository);
  });

  final movieTest = <Movie>[];
  const queryTest = 'Batman';
  test('should get list of movie from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(queryTest))
        .thenAnswer((_) async => Right(movieTest));
    // act
    final result = await searchMovie.execute(queryTest);
    // assert
    expect(result, Right(movieTest));
  });
}
