import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailtvBloc fakeDetailtvBloc;
  late FakeRecommendationtvBloc fakeRecommendationtvBloc;
  late FakeWatchlisttvBloc fakeWatchlisttvBloc;

  setUp(() {
    fakeDetailtvBloc = FakeDetailtvBloc();
    registerFallbackValue(FakeDetailtvE());
    registerFallbackValue(FakeDetailtv());
    fakeRecommendationtvBloc = FakeRecommendationtvBloc();
    registerFallbackValue(FakeRecommendationtvE());
    registerFallbackValue(FakeRecommendationtv());
    fakeWatchlisttvBloc = FakeWatchlisttvBloc();
    registerFallbackValue(FakeWatchlisttvE());
    registerFallbackValue(FakeWatchlisttv());
  });

  tearDown(() {
    fakeDetailtvBloc.close();
    fakeRecommendationtvBloc.close();
    fakeWatchlisttvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailtvBloc>(
          create: (context) => fakeDetailtvBloc,
        ),
        BlocProvider<RecommendationtvBloc>(
          create: (context) => fakeRecommendationtvBloc,
        ),
        BlocProvider<WatchlisttvBloc>(
          create: (context) => fakeWatchlisttvBloc,
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
    when(() => fakeDetailtvBloc.state).thenReturn(tvDetailLoading());
    when(() => fakeRecommendationtvBloc.state).thenReturn(tvRecomLoading());
    when(() => fakeWatchlisttvBloc.state).thenReturn(WatchlisttvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const tvDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailtvBloc.state)
        .thenReturn(const tvDetailHasData(tvDetailTest));
    when(() => fakeRecommendationtvBloc.state)
        .thenReturn(tvRecomHasData(tvTestList));
    when(() => fakeWatchlisttvBloc.state)
        .thenReturn(WatchlisttvHasList(tvTestList));
    await tester
        .pumpWidget(_createTestableWidget(const tvDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tv detail content')), findsOneWidget);
  });
}
