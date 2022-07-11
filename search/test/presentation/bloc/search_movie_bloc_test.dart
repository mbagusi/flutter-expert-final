import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovie mockSearchMovie;

  final movieModelTest = Movie(
    adult: false,
    backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
    genreIds: const [14, 28, 80],
    id: 297761,
    originalTitle: "Suicide Squad",
    overview:
        "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
    popularity: 48.261451,
    posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
    releaseDate: "2016-08-03",
    title: "Suicide Squad",
    video: false,
    voteAverage: 5.91,
    voteCount: 1466,
  );
  final movieListTest = <Movie>[movieModelTest];
  const queryTest = 'batman';

  setUp(() {
    mockSearchMovie = MockSearchMovie();
    movieSearchBloc = MovieSearchBloc(mockSearchMovie);
  });

  group('Search movie with bloc', () {
    test('initial state should be empty', () {
      expect(movieSearchBloc.state, SearchEmpty());
    });

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [Loading, HasData] when search Movie data is successfully',
      build: () {
        when(mockSearchMovie.execute(queryTest))
            .thenAnswer((_) async => Right(movieListTest));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasMovieData(movieListTest),
      ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(queryTest));
      },
    );

    blocTest<MovieSearchBloc, SearchState>(
      'Should emit [Loading, Error] when get movie search is unsuccessful',
      build: () {
        when(mockSearchMovie.execute(queryTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(queryTest));
      },
    );
  });
}
