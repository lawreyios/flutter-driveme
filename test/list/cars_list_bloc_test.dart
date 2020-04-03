import 'package:driveme/dependency_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import '../database/mock_car_data_provider.dart';

void main() {
  setupLocator();
  var carsListBloc = locator<CarsListBloc>();

  test('List of Cars is well sorted in alphabectical order', () async {
    // TODO 3: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    carsListBloc.loadItems();

    // TODO 4: Load Data from Data Stream
    var carsListData = await carsListBloc.outCars.take(1).toList();
    var carsList = carsListData.first.items;

    // TODO 5: Load & Sort Mock Data for Verification
    CarsList databaseCarsData = await MockCarDataProvider().loadCars();
    databaseCarsData.items
        .sort(carsListBloc.alphabetiseItemsByTitleIgnoreCases);

    // TODO 6: Verify Car Data
    for (var i = 0; i < carsList.length; i++) {
      final actualTitle = carsList.elementAt(i).title;
      final expectedTitle = databaseCarsData.items[i].title;
      expect(actualTitle, equals(expectedTitle));

      final actualDescription = carsList.elementAt(i).description;
      final expectedDescription = databaseCarsData.items[i].description;
      expect(actualDescription, equals(expectedDescription));

      final actualPricePerDay = carsList.elementAt(i).pricePerDay;
      final expectedPricePerDay = databaseCarsData.items[i].pricePerDay;
      expect(actualPricePerDay, equals(expectedPricePerDay));

      final actualSelection = carsList.elementAt(i).selected;
      final expectedSelection = i == 0 ? true : false; // Hyundai Sonata 2017 is selected
      expect(actualSelection, expectedSelection);

      final actualFeatures = carsList.elementAt(i).features;
      final expectedFeatures = databaseCarsData.items[i].features;

      expect(listEquals(actualFeatures, expectedFeatures), true);
    }
  });

  test('Stream is updated when a Car is Selected', () async {
    // TODO 7: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 8: Select a Car
    carsListBloc.selectItem(2); // Selects Mercedes-Benz 2017

    // TODO 9: Load Data from Second Data Stream
    var carsListData = await carsListBloc.outCars.take(2).toList();
    var carsList = carsListData.last.items;

    // TODO 10: Verify Car is now Selected
    expect(carsList.elementAt(0).selected, true);
    expect(carsList.elementAt(1).selected, true);
    expect(carsList.elementAt(2).selected, false);
    expect(carsList.elementAt(3).selected, false);
    expect(carsList.elementAt(4).selected, false);
    expect(carsList.elementAt(5).selected, false);
  });

  test('Stream is updated when a Car is Deselected', () async {
    // TODO 11: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 12: Select a Car
    carsListBloc.selectItem(2); // Selects Mercedes-Benz 2017

    // TODO 13: Load Data from Second Data Stream
    var carsListData = await carsListBloc.outCars.take(2).toList();
    var carsList = carsListData.last.items;

    // TODO 14: Verify that Car is deselected
    expect(carsList.elementAt(0).selected, true);
    expect(carsList.elementAt(1).selected, true);
    expect(carsList.elementAt(2).selected, false);
    expect(carsList.elementAt(3).selected, false);
    expect(carsList.elementAt(4).selected, false);
    expect(carsList.elementAt(5).selected, false);

    // TODO 15: Deselect a Car
    carsListBloc.deselectItem(2); // Deselects Mercedes-Benz 2017

    // TODO 16: Load Data from Second Data Stream again
    carsListData = await carsListBloc.outCars.take(2).toList();
    carsList = carsListData.last.items;

    // TODO 17: Verify that Car is now deselected
    expect(carsList.elementAt(0).selected, true);
    expect(carsList.elementAt(1).selected, false);
    expect(carsList.elementAt(2).selected, false);
    expect(carsList.elementAt(3).selected, false);
    expect(carsList.elementAt(4).selected, false);
    expect(carsList.elementAt(5).selected, false);
  });
}
