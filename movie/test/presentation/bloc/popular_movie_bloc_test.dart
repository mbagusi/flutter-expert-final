import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovie mockGetPopularMovie;

  setUp(() {
    mockGetPopularMovie = MockGetPopularMovie();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovie);
  });

  final movieList = <Movie>[];

  test("PopularMovieBloc initial state should be empty", () {
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  group('Popular movie test', () {
    blocTest<PopularMovieBloc, MovieState>(
        'Should emit [Loading, HasData] when data is fetched successfully',
        build: () {
          when(mockGetPopularMovie.execute())
              .thenAnswer((_) async => Right(movieList));
          return popularMovieBloc;
        },
        act: (bloc) => bloc.add(PopularMovie()),
        expect: () => [PopularMovieLoading(), PopularMovieHasData(movieList)],
        verify: (bloc) {
          verify(mockGetPopularMovie.execute());
        });

    blocTest<PopularMovieBloc, MovieState>(
        'Should emit [Loading, Error] when data is failed to fetch',
        build: () {
          when(mockGetPopularMovie.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return popularMovieBloc;
        },
        act: (bloc) => bloc.add(PopularMovie()),
        expect: () =>
            [PopularMovieLoading(), const PopularMovieError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovie.execute());
        });
  });
}
