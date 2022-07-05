import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeWatchlisttvBloc fakeWatchlisttvBloc;

  setUp(() {
    fakeWatchlisttvBloc = FakeWatchlisttvBloc();
    registerFallbackValue(FakeWatchlisttvE());
    registerFallbackValue(FakeWatchlisttv());
  });

  tearDown(() {
    fakeWatchlisttvBloc.close();
  });
  Widget _createTestableWidget(Widget body) {
    return BlocProvider<WatchlisttvBloc>(
      create: (_) => fakeWatchlisttvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlisttvBloc.state).thenReturn(WatchlisttvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const WatchlisttvPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, tvCardList, and WatchlisttvPage when data is fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeWatchlisttvBloc.state)
        .thenReturn(WatchlisttvHasList(tvTestList));
    await tester.pumpWidget(_createTestableWidget(const WatchlisttvPage()));
    await tester.pump();

    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(tvCardList), findsOneWidget);
    expect(find.byKey(const Key('watchlist tv page')), findsOneWidget);
  });

  testWidgets('Should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlisttvBloc.state)
        .thenReturn(const WatchlisttvError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_createTestableWidget(const WatchlisttvPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
