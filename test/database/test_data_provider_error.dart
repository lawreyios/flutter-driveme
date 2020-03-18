import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/models/car.dart';

const String ERROR_MESSAGE = "This is an error message";

class TestDataProviderError implements CarsDataProvider {

  @override
  Future<CarsList> loadCars() {
    return Future.value(CarsList(null, ERROR_MESSAGE));
  }

}

