import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelperTv mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelperTv();
    dataSource =
        TvLocalDataSourceImpl(databaseHelperTv: mockDatabaseHelperTv);
  });

  group('save watchlist Tv', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchListTv(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchListTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist Tv', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchListTv(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchListTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tvId = 23;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tvId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tvId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tvId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tvId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchListTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
