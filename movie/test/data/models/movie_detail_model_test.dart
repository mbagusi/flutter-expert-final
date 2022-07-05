import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

void main() {
  const movieDetailModelTest = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1000,
    genres: [],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 20,
    posterPath: 'posterPath',
    releaseDate: '16-12-2020',
    revenue: 100,
    runtime: 160,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 10.9,
    voteCount: 200,
  );

  final movieDetailTest = movieDetailModelTest.toEntity();
  final movieDetailJsonTest = movieDetailModelTest.toJson();

  group('Movie detail model test', () {
    test('Should return a subclass of movie detail model entity', () {
      final result = movieDetailModelTest.toEntity();
      expect(result, movieDetailTest);
    });

    test('Should become a json data of movie detail model', () {
      final result = movieDetailModelTest.toJson();
      expect(result, movieDetailJsonTest);
    });

    test('Should become a instance of  movie detail response model', () {
      final result = MovieDetailResponse.fromJson(movieDetailJsonTest);
      expect(result, movieDetailModelTest);
    });
  });
}
