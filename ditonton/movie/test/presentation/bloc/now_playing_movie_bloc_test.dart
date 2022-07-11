import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy/dummy_movie_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovie mockGetNowPlayingMovie;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovie();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovie);
  });

  test('NowPlayingMovieBloc initial state should be empty ', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieEmpty());
  });

  group('Now playing movie test', () {
    blocTest<NowPlayingMovieBloc, MovieState>(
        'should emits [Loading, HasData] when data is successfully fetched.',
        build: () {
          when(mockGetNowPlayingMovie.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return nowPlayingMovieBloc;
        },
        act: (bloc) => bloc.add(NowPlayingMovie()),
        expect: () => <MovieState>[
              NowPlayingMovieLoading(),
              NowPlayingMovieHasData(testMovieList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovie.execute());
          return NowPlayingMovie().props;
        });

    blocTest<NowPlayingMovieBloc, MovieState>(
      'should emits [Loading, Error] when now playing movie data is failed to fetch',
      build: () {
        when(mockGetNowPlayingMovie.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(NowPlayingMovie()),
      expect: () => <MovieState>[
        NowPlayingMovieLoading(),
        const NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingMovieLoading(),
    );
  });
}
