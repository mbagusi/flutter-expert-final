import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvStatus tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetWatchlistTvStatus(mockTvRepository);
  });

  test('should get watchlist TV series status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await tvUsecase.execute(1);
    // assert
    expect(result, true);
  });
}
