import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovie mockGetTopRatedMovie;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovie();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  final movieList = <Movie>[];

  test("TopRatedMovieBloc initial state should be empty", () {
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  group(
    'Top rated movie test',
    () {
      blocTest<TopRatedMovieBloc, MovieState>(
        'Should emit [Loading, HasData] when top rated movie data is fetched successfully',
        build: () {
          when(mockGetTopRatedMovie.execute())
              .thenAnswer((_) async => Right(movieList));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(TopRatedMovie()),
        expect: () => [TopRatedMovieLoading(), TopRatedMovieHasData(movieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovie.execute());
        },
      );

      blocTest<TopRatedMovieBloc, MovieState>(
        'Should emit [Loading, Error] when get top rated movie data is failed to fetched',
        build: () {
          when(mockGetTopRatedMovie.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(TopRatedMovie()),
        expect: () => [
          TopRatedMovieLoading(),
          const TopRatedMovieError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovie.execute());
        },
      );
    },
  );
}
