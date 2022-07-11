import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvBloc = RecommendationTvBloc(mockGetTvRecommendations);
  });

  const idTest = 1;
  final tvTest = <Tv>[];

  test("RecommendationTvBloc initial state should be empty", () {
    expect(recommendationTvBloc.state, TvRecomEmpty());
  });

  group(
    'Recommendation TV series Test',
    () {
      blocTest<RecommendationTvBloc, TvState>(
        'Should emit [Loading, HasData] when recommendation TV series data is fetched successfully',
        build: () {
          when(mockGetTvRecommendations.execute(idTest))
              .thenAnswer((_) async => Right(tvTest));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTv(idTest)),
        expect: () => [TvRecomLoading(), TvRecomHasData(tvTest)],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationTvBloc, TvState>(
        'Should emit [Loading, Error] when get recommendation TV series data is failed to fetch',
        build: () {
          when(mockGetTvRecommendations.execute(idTest)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTv(idTest)),
        expect: () =>
            [TvRecomLoading(), const TvRecomError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendationTvBloc, TvState>(
        'should emits [Loading, Empty] when recommendation TV series data is empty',
        build: () {
          when(mockGetTvRecommendations.execute(idTest))
              .thenAnswer((_) async => const Right([]));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const RecommendationTv(idTest)),
        expect: () => <TvState>[
          TvRecomLoading(),
          const TvRecomHasData([]),
        ],
      );
    },
  );
}
