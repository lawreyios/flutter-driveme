import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/details/details_page.dart';
import 'package:driveme/list/list_bloc.dart';

import '../database/test_data_provider.dart';

CarsList cars;

void main() {
  testWidgets('Unselected Car Details Page should be shown as Unselected',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    CarsList cars = await TestDataProvider().loadCars();
    cars.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(DetailsPageSelectedWrapper(cars.items.first.id));
    await tester.pump(Duration.zero);

    final carDetailsKey = find.byKey(Key("car_details"));
    expect(carDetailsKey, findsOneWidget);

    final pageTitleFinder = find.text(cars.items.first.title);
    expect(pageTitleFinder, findsOneWidget);

    final notSelectedTextFinder = find.text("NOT SELECTED");
    expect(notSelectedTextFinder, findsOneWidget);

    final descriptionTextFinder = find.text(cars.items.first.description);
    expect(descriptionTextFinder, findsOneWidget);

    final featuresTitleTextFinder = find.text("Features");
    expect(featuresTitleTextFinder, findsOneWidget);

    var allFeatures = StringBuffer();
    cars.items.first.features.forEach((feature) {
      allFeatures.write('\n' + feature + '\n');
    });

    final featureTextFinder = find.text(allFeatures.toString());
    await tester.ensureVisible(featureTextFinder);
    expect(featureTextFinder, findsOneWidget);

    final selectButtonFinder = find.text("SELECT");
    await tester.ensureVisible(selectButtonFinder);
    expect(selectButtonFinder, findsOneWidget);

    print("A");
  });

  testWidgets('Selected Car Details Page should be shown as Selected',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestNewDataProvider());
    await ListBloc().loadItems();    

    await tester.pumpWidget(DetailsPageSelectedWrapper(3));

    await tester.pump(Duration.zero);

    final carDetailsKey = find.byKey(Key("car_details"));
    expect(carDetailsKey, findsOneWidget);

    final pageTitleFinder = find.text("Car 3");
    expect(pageTitleFinder, findsOneWidget);

    final notSelectedTextFinder = find.text("SELECTED");
    expect(notSelectedTextFinder, findsOneWidget);

    final descriptionTextFinder = find.text("description");
    expect(descriptionTextFinder, findsOneWidget);

    final featuresTitleTextFinder = find.text("Features");
    expect(featuresTitleTextFinder, findsOneWidget);

    final selectButtonFinder = find.text("DESELECT");
    await tester.ensureVisible(selectButtonFinder);
    expect(selectButtonFinder, findsOneWidget);
  });

  testWidgets('Selecting Car Updates the Widget', (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestNewDataProvider());
    await ListBloc().loadItems();

    CarsList cars = await TestNewDataProvider().loadCars();
    cars.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(DetailsPageSelectedWrapper(cars.items.first.id));
    await tester.pump(Duration.zero);

    final selectButtonFinder = find.text("SELECT");
    await tester.ensureVisible(selectButtonFinder);
    await tester.tap(selectButtonFinder);

    await tester.pump(Duration.zero);

    final deselectButtonFinder = find.text("DESELECT");
    await tester.ensureVisible(deselectButtonFinder);
    expect(deselectButtonFinder, findsOneWidget);
  });

  testWidgets('Selecting Car Updates the Widget', (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestNewDataProvider());
    await ListBloc().loadItems();

    CarsList cars = await TestNewDataProvider().loadCars();
    cars.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(DetailsPageSelectedWrapper(cars.items.first.id));
    await tester.pump(Duration.zero);

    final selectButtonFinder = find.text("SELECT");
    await tester.ensureVisible(selectButtonFinder);
    await tester.tap(selectButtonFinder);

    await tester.pump(Duration.zero);

    final deselectButtonFinder = find.text("DESELECT");
    await tester.ensureVisible(deselectButtonFinder);
    await tester.tap(deselectButtonFinder);

    await tester.pump(Duration.zero);

    final newSelectButtonFinder = find.text("SELECT");
    await tester.ensureVisible(newSelectButtonFinder);
    expect(newSelectButtonFinder, findsOneWidget);
  });
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
