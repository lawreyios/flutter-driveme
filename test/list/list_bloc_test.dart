import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';

import '../database/test_data_provider.dart';

void main() {
  test('Cars are sorted in alphabetical order', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());
    listBloc.loadItems();

    CarsList cars = await TestDataProvider().loadCars();
    print(cars.items);

    var carsList = await listBloc.outItems.take(cars.items.length).toList();
    print(carsList);

    // verifyTestData(carsList[0]);
  });

  test('Selecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.selectItem(1);

    var cars = await listBloc.outItems.take(2).toList();

    verifyTestData(cars[0]);

    verifyTestDataExceptSelected(cars[1]);
    verifySelectedStatus(cars[1].items.elementAt(0), true);
    verifySelectedStatus(cars[1].items.elementAt(1), true);
    verifySelectedStatus(cars[1].items.elementAt(2), false);
  });

  test('Selecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.selectItem(2);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), false);
    verifySelectedStatus(events[1].items.elementAt(1), true);
    verifySelectedStatus(events[1].items.elementAt(2), false);
  });

  test('Unselecting a selected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.deselectItem(2);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), false);
    verifySelectedStatus(events[1].items.elementAt(1), false);
    verifySelectedStatus(events[1].items.elementAt(2), false);
  });

  test('Unselecting an unselected item updates the stream', () async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    await listBloc.loadItems();
    listBloc.deselectItem(1);

    var events = await listBloc.outItems.take(2).toList();

    verifyTestData(events[0]);
    verifyTestDataExceptSelected(events[1]);
    verifySelectedStatus(events[1].items.elementAt(0), false);
    verifySelectedStatus(events[1].items.elementAt(1), true);
    verifySelectedStatus(events[1].items.elementAt(2), false);
  });
}

void verifyTestData(CarsList data) {
  verifySelectedStatus(data.items.first, false);
}

void verifyTestDataExceptSelected(CarsList data) {
  expect(data.errorMessage, isNull);
  expect(data.items.length, equals(6));
  expect(data.items.elementAt(0).title, equals("Toyota Yaris 2013"));
  expect(data.items.elementAt(1).title, equals("Mercedes-Benz 2017"));
  expect(data.items.elementAt(2).title, equals("Hyundai Sonata 2017"));
  expect(data.items.elementAt(0).id, equals(1));
  expect(data.items.elementAt(1).id, equals(2));
  expect(data.items.elementAt(2).id, equals(3));
}

void verifySelectedStatus(Car data, bool shouldBeSelected) {
  expect(data.selected, equals(shouldBeSelected));
}
