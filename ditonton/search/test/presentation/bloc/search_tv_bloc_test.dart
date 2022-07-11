import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;

  final tvModelTest = Tv(
      backdropPath: 'backdropPath',
      genreIds: const [1, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 10.9,
      posterPath: 'posterPath',
      firstAirDate: '2019-09-17',
      name: 'name',
      voteAverage: 18.76,
      voteCount: 877);

  final tvListTest = <Tv>[tvModelTest];
  const queryTest = 'Spy x Family';

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  group('Search TV series with bloc', () {
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, SearchEmpty());
    });

    blocTest<TvSearchBloc, SearchState>(
      'Should emit [Loading, HasData] when search TV series data is successfully',
      build: () {
        when(mockSearchTv.execute(queryTest))
            .thenAnswer((_) async => Right(tvListTest));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasTvData(tvListTest),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(queryTest));
      },
    );

    blocTest<TvSearchBloc, SearchState>(
      'Should emit [Loading, Error] when get TV series search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(queryTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(queryTest));
      },
    );
  });
}
