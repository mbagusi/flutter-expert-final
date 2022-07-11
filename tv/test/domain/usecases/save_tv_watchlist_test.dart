import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = SaveTvWatchlist(mockTvRepository);
  });

  test('should save watchlist TV series to repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(tvDetailTest))
        .thenAnswer((_) async => const Right('Added from watchlist'));
    // act
    final result = await tvUsecase.execute(tvDetailTest);
    // assert
    verify(mockTvRepository.saveWatchlist(tvDetailTest));
    expect(result, const Right('Added from watchlist'));
  });
}
