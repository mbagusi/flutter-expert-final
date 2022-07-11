// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

void main() {
  final modelTvTest = TvModel(
    backdropPath: 'iniBackdropPathYa',
    genreIds: const [7, 8, 9],
    id: 022,
    overview: 'apapunYangPentingIniOverview',
    popularity: 221.9,
    posterPath: 'lohIniposterPath',
    voteAverage: 9.7,
    voteCount: 1000,
    name: 'iniNamaLoh',
    firstAirDate: '25-05-2021',
    originalName: 'ingatIniOriginalName',
  );

  final tvTest = Tv(
    backdropPath: 'iniBackdropPathYa',
    genreIds: const [7, 8, 9],
    id: 022,
    overview: 'apapunYangPentingIniOverview',
    popularity: 221.9,
    posterPath: 'lohIniposterPath',
    voteAverage: 9.7,
    voteCount: 1000,
    name: 'iniNamaLoh',
    firstAirDate: '25-05-2021',
    originalName: 'ingatIniOriginalName',
  );

  test('should be a subclass of TV series entity', () async {
    final result = modelTvTest.toEntity();
    expect(result, tvTest);
  });
}
