import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUp(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvE());
    registerFallbackValue(FakePopularTvS());
  });

  tearDown(() {
    fakePopularTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(PopularTvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const PopularTvPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and PopularTvPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state)
        .thenReturn(PopularTvHasData(tvTestList));
    await tester.pumpWidget(_createTestableWidget(const PopularTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCardList), findsOneWidget);
    expect(find.byKey(const Key('Popular TV series page')), findsOneWidget);
  });
}
