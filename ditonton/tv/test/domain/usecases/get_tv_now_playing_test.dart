import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetNowPlayingTv(mockTvRepository);
  });

  final tvTest = <Tv>[];

  test('should get list of TV series from the repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(tvTest));
    // act
    final result = await tvUsecase.execute();
    // assert
    expect(result, Right(tvTest));
  });
}