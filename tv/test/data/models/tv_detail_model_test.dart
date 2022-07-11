// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_model.dart';

void main() {
  const tvDetailModelTest = TvDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 8.0,
    voteCount: 100,
    firstAirDate: '16-20-2019',
  );

  final tvDetailTest = tvDetailModelTest.toEntity();
  final tvDetailJsonTest = tvDetailModelTest.toJson();

  group('TV series detail model test', () {
    test('Should return a subclass og tv detail model entity', () {
      final result = tvDetailModelTest.toEntity();
      expect(result, tvDetailTest);
    });
  });

  test('Should become a json data of tv detail model', () {
    final result = tvDetailModelTest.toJson();
    expect(result, tvDetailJsonTest);
  });
}
