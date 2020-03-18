import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:driveme/database/car_database.dart';
import 'package:driveme/models/car.dart';

class ListBloc {
  static final ListBloc _singleton = new ListBloc._internal();

  factory ListBloc() {
    return _singleton;
  }

  ListBloc._internal();

  CarsDataProvider provider = CarDatabase();

  BehaviorSubject<CarsList> _itemsController = BehaviorSubject<CarsList>();
  Stream<CarsList> get outItems => _itemsController.stream;

  Future loadItems() async {
    CarsList items = await provider.loadCars();
    if (items.items != null) {
      items.items.sort(alphabetiseItemsByTitleIgnoreCases);
    }
    _itemsController.sink.add(items);
  }

  int alphabetiseItemsByTitleIgnoreCases(Car a, Car b) {
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }

  void selectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      List<Car> newList = List<Car>();
      for (var item in listOfItems.items) {
        if (item.id == id) {
          newList.add(Car(item.id, item.title, item.description, item.url,
              item.pricePerDay, true, item.features));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(CarsList(newList, null));
      subscription.cancel();
    });
  }

  void deselectItem(int id) {
    StreamSubscription subscription;
    subscription = ListBloc().outItems.listen((listOfItems) async {
      List<Car> newList = List<Car>();
      for (var item in listOfItems.items) {
        if (item.id == id) {
          newList.add(Car(item.id, item.title, item.description, item.url,
              item.pricePerDay, false, item.features));
        } else {
          newList.add(item);
        }
      }
      _itemsController.sink.add(CarsList(newList, null));
      subscription.cancel();
    });
  }

  void dispose() {
    _itemsController.close();
  }

  void injectDataProviderForTest(CarsDataProvider provider) {
    this.provider = provider;
  }
}

abstract class CarsDataProvider {
  Future<CarsList> loadCars();
}
