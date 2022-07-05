import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy/dummy_movie_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailMovieBloc fakeDetailMovieBloc;
  late FakeRecommendationMovieBloc fakeRecommendationMovieBloc;
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUp(() {
    fakeDetailMovieBloc = FakeDetailMovieBloc();
    registerFallbackValue(FakeDetailMovieE());
    registerFallbackValue(FakeDetailMovieS());
    fakeRecommendationMovieBloc = FakeRecommendationMovieBloc();
    registerFallbackValue(FakeRecommendationMovieE());
    registerFallbackValue(FakeRecommendationMovieS());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieE());
    registerFallbackValue(FakeWatchlistMovieS());
  });

  tearDown(() {
    fakeDetailMovieBloc.close();
    fakeRecommendationMovieBloc.close();
    fakeWatchlistMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (context) => fakeDetailMovieBloc,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (context) => fakeRecommendationMovieBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const idTest = 1;

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeRecommendationMovieBloc.state)
        .thenReturn(MovieRecomLoading());
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const MovieDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationMovieBloc.state)
        .thenReturn(MovieRecomHasData(testMovieList));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasList(testMovieList));
    await tester
        .pumpWidget(_createTestableWidget(const MovieDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('movie detail content')), findsOneWidget);
  });
}
