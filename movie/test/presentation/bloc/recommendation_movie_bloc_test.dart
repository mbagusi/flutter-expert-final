import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  const idTest = 1;
  final movieTest = <Movie>[];

  test("RecommendationMovieBloc initial state should be empty", () {
    expect(recommendationMovieBloc.state, MovieRecomEmpty());
  });

  group(
    'Recommendation movie Test',
    () {
      blocTest<RecommendationMovieBloc, MovieState>(
        'Should emit [Loading, HasData] when recommendation movie data is fetched successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => Right(movieTest));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () => [MovieRecomLoading(), MovieRecomHasData(movieTest)],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationMovieBloc, MovieState>(
        'Should emit [Loading, Error] when get recommendation movie data is failed to fetch',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () =>
            [MovieRecomLoading(), const MovieRecomError('Server Failure')],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationMovieBloc, MovieState>(
        'should emits [Loading, Empty] when recommendation movie data is empty',
        build: () {
          when(mockGetMovieRecommendations.execute(idTest))
              .thenAnswer((_) async => const Right([]));
          return recommendationMovieBloc;
        },
        act: (bloc) => bloc.add(const RecommendationMovie(idTest)),
        expect: () => <MovieState>[
          MovieRecomLoading(),
          const MovieRecomHasData([]),
        ],
      );
    },
  );
}
