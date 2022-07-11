import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('NowPlayingTvBloc initial state should be empty ', () {
    expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
  });

  group('Now playing TV series test', () {
    blocTest<NowPlayingTvBloc, TvState>(
        'should emits [Loading, HasData] when data is successfully fetched.',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Right(tvTestList));
          return nowPlayingTvBloc;
        },
        act: (bloc) => bloc.add(NowPlayingTv()),
        expect: () => <TvState>[
              NowPlayingTvLoading(),
              NowPlayingTvHasData(tvTestList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
          return NowPlayingTv().props;
        });

    blocTest<NowPlayingTvBloc, TvState>(
      'should emits [Loading, Error] when now playing TV series data is failed to fetch',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      expect: () => <TvState>[
        NowPlayingTvLoading(),
        const NowPlayingTvError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingTvLoading(),
    );
  });
}
