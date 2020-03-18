import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';

class DetailsBloc {

  static final DetailsBloc _singleton = new DetailsBloc._internal();

  factory DetailsBloc() {
    return _singleton;
  }

  DetailsBloc._internal();

  BehaviorSubject<Car> _itemController = BehaviorSubject<Car>();
  Stream<Car> get outItem => _itemController.stream;
  StreamSubscription _subscription;
  int _currentId;

  void getItem(int id) async {
    // Reset the item
    _itemController.sink.add(null);

    _currentId = id;
    if (_subscription != null) {
      _subscription.cancel();
    }

    _subscription = ListBloc().outItems.listen((listOfItems) async {
      for (var item in listOfItems.items){
        if (item.id == _currentId) {
          _itemController.sink.add(item);
          break;
        }
      }
    });
  }

  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    _itemController.close();
  }

}
