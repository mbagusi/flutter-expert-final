// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:Tv/data/models/Tv_detail_model.dart';

void main() {
  const TvDetailModelTest = TvDetailResponse(
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

  final TvDetailTest = TvDetailModelTest.toEntity();
  final TvDetailJsonTest = TvDetailModelTest.toJson();

  group('TV series detail model test', () {
    test('Should return a subclass og Tv detail model entity', () {
      final result = TvDetailModelTest.toEntity();
      expect(result, TvDetailTest);
    });
  });

  test('Should become a json data of Tv detail model', () {
    final result = TvDetailModelTest.toJson();
    expect(result, TvDetailJsonTest);
  });
}
