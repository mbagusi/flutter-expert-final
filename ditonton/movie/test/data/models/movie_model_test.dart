import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

void main() {
  // ignore: prefer_const_constructors
  final modelMovieTest = MovieModel(
    adult: false,
    backdropPath: 'iniBackdropPath',
    genreIds: const [12, 23, 34],
    id: 218,
    originalTitle: 'pokoknyaIniTitlenya',
    overview: 'apapunYangPentingIniOverview',
    popularity: 200.9,
    posterPath: 'lohIniposterPath',
    releaseDate: 'masaIyainireleaseDate',
    title: 'titleNihBos',
    video: false,
    voteAverage: 9.7,
    voteCount: 1000,
  );

  final movieTest = Movie(
    adult: false,
    backdropPath: 'iniBackdropPath',
    genreIds: const [12, 23, 34],
    id: 218,
    originalTitle: 'pokoknyaIniTitlenya',
    overview: 'apapunYangPentingIniOverview',
    popularity: 200.9,
    posterPath: 'lohIniposterPath',
    releaseDate: 'masaIyainireleaseDate',
    title: 'titleNihBos',
    video: false,
    voteAverage: 9.7,
    voteCount: 1000,
  );

  test('should be a subclass of Movie entity', () async {
    final result = modelMovieTest.toEntity();
    expect(result, movieTest);
  });
}
