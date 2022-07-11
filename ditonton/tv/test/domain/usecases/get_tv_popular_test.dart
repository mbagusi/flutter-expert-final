import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetPopularTv(mockTvRepository);
  });

  final tvTest = <Tv>[];

  group('Get Popular TV series Test', () {
    test(
        'should get list of TV series from the repository when execute function is called',
        () async {
      // arrange
      when(mockTvRepository.getPopularTv())
          .thenAnswer((_) async => Right(tvTest));
      // act
      final result = await tvUsecase.execute();
      // assert
      expect(result, Right(tvTest));
    });
  });
}
