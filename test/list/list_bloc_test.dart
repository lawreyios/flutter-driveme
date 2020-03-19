import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';
import '../database/test_data_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('List of Cars is well sorted in alphabectical order', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());
    listBloc.loadItems();

    var carsListData = await listBloc.outCars.take(1).toList();
    var carsList = carsListData.first.items;

    CarsList databaseCarsData = await TestDataProvider().loadCars();
    databaseCarsData.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

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
      final expectedSelection = i == 5 ? true : false;    
      expect(actualSelection, expectedSelection);

      final actualFeatures = carsList.elementAt(i).features;
      final expectedFeatures = databaseCarsData.items[i].features;

      expect(listEquals(actualFeatures, expectedFeatures), true);
    }
  });

  test('Stream is updated when a Car is Selected', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());
    await listBloc.loadItems();

    listBloc.selectItem(2);

    var carsListData = await listBloc.outCars.take(2).toList();
    var carsList = carsListData.last.items;

    expect(carsList.elementAt(0).selected, false);
    expect(carsList.elementAt(1).selected, true);
    expect(carsList.elementAt(2).selected, false);
    expect(carsList.elementAt(3).selected, false);
    expect(carsList.elementAt(4).selected, false);
    expect(carsList.elementAt(5).selected, true);
  });

  test('Stream is updated when a Car is Deselected', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());
    await listBloc.loadItems();

    listBloc.selectItem(2);

    var carsListData = await listBloc.outCars.take(2).toList();
    var carsList = carsListData.last.items;

    listBloc.deselectItem(2);
    
    carsListData = await listBloc.outCars.take(2).toList();
    carsList = carsListData.last.items;

    expect(carsList.elementAt(0).selected, false);
    expect(carsList.elementAt(1).selected, false);
    expect(carsList.elementAt(2).selected, false);
    expect(carsList.elementAt(3).selected, false);
    expect(carsList.elementAt(4).selected, false);
    expect(carsList.elementAt(5).selected, true);
  });
}
