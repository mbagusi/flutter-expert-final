import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv searchTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    searchTv = SearchTv(mockTvRepository);
  });

  final movieTest = <Tv>[];
  const queryTest = 'Spy X Family';
  test('should get list of TV series from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(queryTest))
        .thenAnswer((_) async => Right(movieTest));
    // act
    final result = await searchTv.execute(queryTest);
    // assert
    expect(result, Right(movieTest));
  });
}
