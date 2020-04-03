import 'package:driveme/constants.dart';
import 'package:driveme/dependency_injector.dart';
import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/details/car_details_page.dart';
import 'package:driveme/list/cars_list_bloc.dart';

import '../database/mock_car_data_provider.dart';

CarsList cars;

void main() {

  setupLocator();
  var carsListBloc = locator<CarsListBloc>();

  testWidgets('Unselected Car Details Page should be shown as Unselected', (WidgetTester tester) async {
    // TODO 35: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 36: Load & Sort Mock Data for Verification
    CarsList cars = await MockCarDataProvider().loadCars();
    cars.items.sort(carsListBloc.alphabetiseItemsByTitleIgnoreCases);

    // TODO 37: Load and render Widget
    await tester.pumpWidget(DetailsPageSelectedWrapper(2)); // Mercedes-Benz 2017
    await tester.pump(Duration.zero);

    // TODO 38: Verify Car Details
    final carDetailsKey = find.byKey(Key(CAR_DETAILS_KEY));
    expect(carDetailsKey, findsOneWidget);

    final pageTitleFinder = find.text(cars.items[1].title); // 2nd car in sorted list
    expect(pageTitleFinder, findsOneWidget);

    final notSelectedTextFinder = find.text(NOT_SELECTED_TITLE);
    expect(notSelectedTextFinder, findsOneWidget);

    final descriptionTextFinder = find.text(cars.items[1].description);
    expect(descriptionTextFinder, findsOneWidget);

    final featuresTitleTextFinder = find.text(FEATURES_TITLE);
    expect(featuresTitleTextFinder, findsOneWidget);

    var allFeatures = StringBuffer();
    cars.items[1].features.forEach((feature) {
      allFeatures.write('\n' + feature + '\n');
    });

    final featureTextFinder = find.text(allFeatures.toString());
    await tester.ensureVisible(featureTextFinder);
    expect(featureTextFinder, findsOneWidget);

    final selectButtonFinder = find.text(SELECT_BUTTON);
    await tester.ensureVisible(selectButtonFinder);
    expect(selectButtonFinder, findsOneWidget);
  });

  testWidgets('Selected Car Details Page should be shown as Selected',
      (WidgetTester tester) async {
    // TODO 39: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 40: Load and render Widget
    await tester.pumpWidget(DetailsPageSelectedWrapper(3)); // Hyundai Sonata 2017
    await tester.pump(Duration.zero);

    // TODO 41: Load Mock Data for Verification
    CarsList actualCarsList = await MockCarDataProvider().loadCars();
    List<Car> actualCars = actualCarsList.items;

    // TODO 42: First Car is Selected, so Verify that
    final carDetailsKey = find.byKey(Key(CAR_DETAILS_KEY));
    expect(carDetailsKey, findsOneWidget);

    final pageTitleFinder = find.text(actualCars[2].title);
    expect(pageTitleFinder, findsOneWidget);

    final notSelectedTextFinder = find.text(SELECTED_TITLE);
    expect(notSelectedTextFinder, findsOneWidget);

    final descriptionTextFinder = find.text(actualCars[2].description);
    expect(descriptionTextFinder, findsOneWidget);

    final featuresTitleTextFinder = find.text(FEATURES_TITLE);
    expect(featuresTitleTextFinder, findsOneWidget);

    var actualFeaturesStringBuffer = StringBuffer();
    actualCars[2].features.forEach((feature) {
      actualFeaturesStringBuffer.write('\n' + feature + '\n');
    });

    final featuresTextFinder = find.text(actualFeaturesStringBuffer.toString());
    await tester.ensureVisible(featuresTextFinder);
    expect(featuresTextFinder, findsOneWidget);

    final selectButtonFinder = find.text(REMOVE_BUTTON);
    await tester.ensureVisible(selectButtonFinder);
    expect(selectButtonFinder, findsOneWidget);
  });

  testWidgets('Selecting Car Updates the Widget', (WidgetTester tester) async {
    // TODO 43: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 44: Load & Sort Mock Data for Verification
    CarsList cars = await MockCarDataProvider().loadCars();
    cars.items.sort(carsListBloc.alphabetiseItemsByTitleIgnoreCases);

    // TODO 45: Load and render Widget for the first car
    await tester.pumpWidget(DetailsPageSelectedWrapper(2)); // Mercedes-Benz 2017
    await tester.pump(Duration.zero);

    // TODO 46: Tap on Select and Deselect to ensure widget updates
    final selectButtonFinder = find.text(SELECT_BUTTON);
    await tester.ensureVisible(selectButtonFinder);
    await tester.tap(selectButtonFinder);

    await tester.pump(Duration.zero);

    final deselectButtonFinder = find.text(REMOVE_BUTTON);
    await tester.ensureVisible(deselectButtonFinder);
    await tester.tap(deselectButtonFinder);

    await tester.pump(Duration.zero);

    final newSelectButtonFinder = find.text(SELECT_BUTTON);
    await tester.ensureVisible(newSelectButtonFinder);
    expect(newSelectButtonFinder, findsOneWidget);
  });
}

class DetailsPageSelectedWrapper extends StatelessWidget {
  final int id;

  DetailsPageSelectedWrapper(this.id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarDetailsPage(id: id),
    );
  }
}
