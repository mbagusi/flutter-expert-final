import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  const idTest = 1;
  test("DetailMovieBloc initial state should be empty", () {
    expect(detailTvBloc.state, TvDetailEmpty());
  });

  group('Detail movie test', () {
    blocTest<DetailTvBloc, TvState>(
      'Should emit [Loading, HasData] when TV series detail data is fetched successfully',
      build: () {
        when(mockGetTvDetail.execute(idTest))
            .thenAnswer((_) async => const Right(tvDetailTest));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(const DetailTv(idTest)),
      expect: () => [TvDetailLoading(), const TvDetailHasData(tvDetailTest)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(idTest));
      },
    );

    blocTest<DetailTvBloc, TvState>(
      'Should emit [Loading, Error] when detail movie data is failed to fetch',
      build: () {
        when(mockGetTvDetail.execute(idTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(const DetailTv(idTest)),
      expect: () =>
          [TvDetailLoading(), const TvDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(idTest));
      },
    );
  });
}
