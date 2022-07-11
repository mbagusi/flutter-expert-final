import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  final tvList = <Tv>[];

  test("PopularTvBloc initial state should be empty", () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  group('Popular TV series test', () {
    blocTest<PopularTvBloc, TvState>(
        'Should emit [Loading, HasData] when popular TV series data is fetched successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularTv()),
        expect: () => [PopularTvLoading(), PopularTvHasData(tvList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });

    blocTest<PopularTvBloc, TvState>(
        'Should emit [Loading, Error] when popular TV series data is failed to fetch',
        build: () {
          when(mockGetPopularTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularTv()),
        expect: () =>
            [PopularTvLoading(), const PopularTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });
  });
}
