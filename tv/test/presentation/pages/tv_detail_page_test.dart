import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailTvBloc fakeDetailTvBloc;
  late FakeRecommendationTvBloc fakeRecommendationTvBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;

  setUp(() {
    fakeDetailTvBloc = FakeDetailTvBloc();
    registerFallbackValue(FakeDetailTvE());
    registerFallbackValue(FakeDetailTvS());
    fakeRecommendationTvBloc = FakeRecommendationTvBloc();
    registerFallbackValue(FakeRecommendationTvE());
    registerFallbackValue(FakeRecommendationTvS());
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvE());
    registerFallbackValue(FakeWatchlistTvS());
  });

  tearDown(() {
    fakeDetailTvBloc.close();
    fakeRecommendationTvBloc.close();
    fakeWatchlistTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(
          create: (context) => fakeDetailTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (context) => fakeRecommendationTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => fakeWatchlistTvBloc,
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
    when(() => fakeDetailTvBloc.state).thenReturn(TvDetailLoading());
    when(() => fakeRecommendationTvBloc.state).thenReturn(TvRecomLoading());
    when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailTvBloc.state)
        .thenReturn(const TvDetailHasData(tvDetailTest));
    when(() => fakeRecommendationTvBloc.state)
        .thenReturn(TvRecomHasData(tvTestList));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTvHasList(tvTestList));
    await tester
        .pumpWidget(_createTestableWidget(const TvDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tv detail content')), findsOneWidget);
  });
}
