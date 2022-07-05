import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy/dummy_movie_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakePopularMovieBloc fakePopularMovieBloc;

  setUp(() {
    fakePopularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularMovieE());
    registerFallbackValue(FakePopularMovieS());
  });

  tearDown(() {
    fakePopularMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => fakePopularMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, MovieCard, and PopularMoviesPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byKey(const Key('Popular movie page')), findsOneWidget);
  });
}
