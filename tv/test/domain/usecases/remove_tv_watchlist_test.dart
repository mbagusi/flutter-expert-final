import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist TV series from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(tvDetailTest))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await tvUsecase.execute(tvDetailTest);
    // assert
    verify(mockTvRepository.removeWatchlist(tvDetailTest));
    expect(result, const Right('Removed from watchlist'));
  });
}
