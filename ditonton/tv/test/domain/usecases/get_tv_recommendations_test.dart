import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetTvRecommendations(mockTvRepository);
  });

  const tId = 1;
  final tvTest = <Tv>[];

  test('should get list of TV series recommendations from the repository',
          () async {
        // arrange
        when(mockTvRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tvTest));
        // act
        final result = await tvUsecase.execute(tId);
        // assert
        expect(result, Right(tvTest));
      });
}