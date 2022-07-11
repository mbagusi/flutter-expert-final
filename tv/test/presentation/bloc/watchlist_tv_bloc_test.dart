import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    watchlistTvBloc = WatchlistTvBloc(
        getWatchlistTv: mockGetWatchlistTv,
        getWatchlistTvStatus: mockGetWatchlistTvStatus,
        removeTvWatchlist: mockRemoveTvWatchlist,
        saveTvWatchlist: mockSaveTvWatchlist);
  });
  test('WatchlistTvBloc initial state should be empty ', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  group('Get watchlist TV series test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emits [Loading, HasList] when watchlist TV series list data is successfully fetched',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right([tvWatchlistTest]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvList()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasList([tvWatchlistTest]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
        return WatchlistTvList().props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emits [Loading, Error] when watchlist TV series list data is failed to fetch',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvList()),
      expect: () => <WatchlistTvState>[
        WatchlistTvLoading(),
        const WatchlistTvError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvLoading(),
    );
  });

  group('Get watchlist status TV series test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should be return true when the TV series watchlist is also true',
      build: () {
        when(mockGetWatchlistTvStatus.execute(tvDetailTest.id))
            .thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistStatusTv(tvDetailTest.id)),
      expect: () => [WatchlistTvLoading(), const WatchlistTvHasStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchlistTvStatus.execute(tvDetailTest.id));
        return WatchlistStatusTv(tvDetailTest.id).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should be return false when the TV series watchlist is also false',
        build: () {
          when(mockGetWatchlistTvStatus.execute(tvDetailTest.id))
              .thenAnswer((_) async => false);
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(WatchlistStatusTv(tvDetailTest.id)),
        expect: () => <WatchlistTvState>[
              WatchlistTvLoading(),
              const WatchlistTvHasStatus(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistTvStatus.execute(tvDetailTest.id));
          return WatchlistStatusTv(tvDetailTest.id).props;
        });
  });

  group('Add watchlist TV series test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should update watchlist status when add movie to watchlist is successfully',
      build: () {
        when(mockSaveTvWatchlist.execute(tvDetailTest))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTv(tvDetailTest)),
      expect: () => [
        const WatchlistTvHasMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(tvDetailTest));
        return const AddWatchlistTv(tvDetailTest).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should throw failure message status when failed to add TV series to watchlist',
      build: () {
        when(mockSaveTvWatchlist.execute(tvDetailTest)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistTv(tvDetailTest)),
      expect: () => [
        const WatchlistTvError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(tvDetailTest));
        return const AddWatchlistTv(tvDetailTest).props;
      },
    );
  });

  group('Remove watchlist TV series test', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should update watchlist status when remove TV series from watchlist is successfully',
      build: () {
        when(mockRemoveTvWatchlist.execute(tvDetailTest))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistTv(tvDetailTest)),
      expect: () => [
        const WatchlistTvHasMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(tvDetailTest));
        return const RemoveWatchlistTv(tvDetailTest).props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should throw failure message status when failed to remove TV series from watchlist',
      build: () {
        when(mockRemoveTvWatchlist.execute(tvDetailTest)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistTv(tvDetailTest)),
      expect: () => [
        const WatchlistTvError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(tvDetailTest));
        return const RemoveWatchlistTv(tvDetailTest).props;
      },
    );
  });
}
