import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetTopRatedTv(mockTvRepository);
  });

  final tvTest = <Tv>[];

  test('should get list of TV series from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tvTest));
    // act
    final result = await tvUsecase.execute();
    // assert
    expect(result, Right(tvTest));
  });
}
