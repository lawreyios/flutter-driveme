import 'package:driveme/details/car_details_bloc.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CarsListBloc());
  locator.registerSingleton(CarDetailsBloc());
}
