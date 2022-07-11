import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test("TopRatedTvBloc initial state should be empty", () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
  });

  final tvList = <Tv>[];
  group(
    'Top rated TV series test',
    () {
      blocTest<TopRatedTvBloc, TvState>(
        'Should emit [Loading, HasData] when top rated movie data is fetched successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTv()),
        expect: () => [TopRatedTvLoading(), TopRatedTvHasData(tvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );

      blocTest<TopRatedTvBloc, TvState>(
        'Should emit [Loading, Error] when get top rated movie data is failed to fetched',
        build: () {
          when(mockGetTopRatedTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTv()),
        expect: () =>
            [TopRatedTvLoading(), const TopRatedTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );
    },
  );
}
