import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/movie_search_page.dart';

import '../../helpers/test_helper.dart';

void main() {
  late FakeMovieSearchBloc fakeMovieSearchBloc;

  setUp(() {
    fakeMovieSearchBloc = FakeMovieSearchBloc();
    registerFallbackValue(FakeMovieSearchE());
    registerFallbackValue(FakeMovieSearchS());
  });

  tearDown(() {
    fakeMovieSearchBloc.close();
  });

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>(
      create: (_) => fakeMovieSearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieSearchBloc.state).thenReturn(SearchLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const MovieSearchPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'should display AppBar, ListView, MovieCard, and SearchMoviePage when data is fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeMovieSearchBloc.state)
        .thenReturn(SearchHasMovieData(testMovieList));
    await tester.pumpWidget(_createTestableWidget(const MovieSearchPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byKey(const Key('movie search page')), findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeMovieSearchBloc.state)
        .thenReturn(const SearchError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_createTestableWidget(const MovieSearchPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
