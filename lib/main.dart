import 'package:driveme/constants.dart';
import 'package:flutter/material.dart';
import 'package:driveme/details/details_bloc.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/list/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }

  @override
  void dispose() {
    ListBloc().dispose();
    DetailsBloc().dispose();
    super.dispose();
  }
}
