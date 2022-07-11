import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvE());
    registerFallbackValue(FakeTopRatedTvS());
  });

  tearDown(() {
    fakeTopRatedTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => fakeTopRatedTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TopRatedTvPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and TopRatedTvPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedTvHasData(tvTestList));
    await tester.pumpWidget(_createTestableWidget(const TopRatedTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCardList), findsOneWidget);
    expect(find.byKey(const Key('Top rated TV series page')), findsOneWidget);
  });
}
