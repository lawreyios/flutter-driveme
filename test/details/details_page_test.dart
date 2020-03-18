import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/details/details_page.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/strings.dart';

import '../database/test_data_provider.dart';

CarsList cars;

void main() {
  testWidgets('Selected car is shown as selected', (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProvider());

    cars = await TestDataProvider().loadCars();
    cars.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(DetailsPageSelectedWrapper(cars.items.first.id));
    await tester.pump(Duration.zero);

    final carDetailsKey = find.byKey(Key("car_details"));
    expect(carDetailsKey, findsOneWidget);

    for (var i in tester.allElements.toList()) {
      print(i.toString());
    }

    // final selectButtonFinder = find.widgetWithText(Text, "Features");
    // await tester.ensureVisible(selectButtonFinder);
    // expect(selectButtonFinder, findsOneWidget);

    // final selectionTitleFinder = find.text("Features");
    // final pageTitleFinder = _getTitleFinder(cars.items.first.title);

    // expect(selectionTitleFinder, findsOneWidget);
    // expect(pageTitleFinder, findsOneWidget);
  });

  testWidgets('Unselected item is shown as unselected',
      (WidgetTester tester) async {
    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageUnselectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final titleFinder = _getTitleFinder("Mercedes-Benz 2017");
    final buttonFinder = _getSelectButtonFinder();

    expect(titleFinder, findsNWidgets(2));
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Select unselected item updates widget and stream',
      (WidgetTester tester) async {
    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageUnselectedWrapper());

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final buttonFinder = _getSelectButtonFinder();
    await tester.tap(buttonFinder);

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final titleFinder = _getSelectedTitleFinder("Mercedes-Benz 2017");
    final pageTitleFinder = _getTitleFinder("Mercedes-Benz 2017");
    final buttonFinder2 = _getRemoveButtonFinder();

    expect(titleFinder, findsOneWidget);
    expect(pageTitleFinder, findsOneWidget);
    expect(buttonFinder2, findsOneWidget);
  });

  testWidgets('Unselect selected item updates widget and stream',
      (WidgetTester tester) async {
    // Inject data provider
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    // Build widget
    await tester.pumpWidget(DetailsPageSelectedWrapper(cars.items.first.id));

    // This causes the stream builder to get the data
    await tester.pump(Duration.zero);

    final buttonFinder = _getRemoveButtonFinder();
    await tester.tap(buttonFinder);

    // Trigger widget to redraw its frames, this causes the stream builder to get the new data
    await tester.pump(Duration.zero);

    final titleFinder = _getTitleFinder("Mercedes-Benz 2017");
    final buttonFinder2 = _getSelectButtonFinder();

    expect(titleFinder, findsNWidgets(2));
    expect(buttonFinder2, findsOneWidget);
  });
}

Finder _getSelectButtonFinder() {
  return find.text(SELECT_BUTTON);
}

Finder _getRemoveButtonFinder() {
  return find.text(REMOVE_BUTTON);
}

Finder _getTitleFinder(String title) {
  return find.text(title);
}

Finder _getSelectedTitleFinder(String title) {
  return find.text(getSelectedTitle(title));
}

class DetailsPageUnselectedWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DetailsPage(id: 1),
    );
  }
}

class DetailsPageSelectedWrapper extends StatelessWidget {
  final int id;

  DetailsPageSelectedWrapper(this.id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DetailsPage(id: id),
    );
  }
}
