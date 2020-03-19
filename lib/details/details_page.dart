import 'package:flutter/material.dart';
import 'package:driveme/details/details_bloc.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/strings.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    DetailsBloc().getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Car>(          
          stream: DetailsBloc().outItem,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<Car> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Text(snapshot.data.title);
            }
          },
        ),
      ),
      body: StreamBuilder<Car>(
        key: Key("car_details"),
        stream: DetailsBloc().outItem,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Car> snapshot) {          
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildDetailsView(snapshot.data);
          }
        },
      ),
    );
  }

  Text _buildFeaturesView(List<dynamic> features) {
    var allFeatures = StringBuffer();
    features.forEach((feature) {
      allFeatures.write('\n' + feature + '\n');
    });
    return Text(allFeatures.toString());
  }

  Widget _buildDetailsView(Car item) {
    Widget button = item.selected
        ? RaisedButton(
            child: Text(REMOVE_BUTTON),
            onPressed: () => ListBloc().deselectItem(widget.id))
        : RaisedButton(
            child: Text(SELECT_BUTTON),
            onPressed: () => ListBloc().selectItem(widget.id),
          );
    return Container(
      padding: EdgeInsets.all(24.0),
      child: ListView(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: (item.url == null || item.url.isEmpty)
                  ? Image.asset('assets/placeholder.png', height: 150, fit: BoxFit.cover)
                  : Image.network(item.url, height: 150, fit: BoxFit.cover)),
          SizedBox(
            height: 11.0,
          ),
          Text(
            item.selected ? getSelectedTitle(item.title) : "NOT SELECTED",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 22.0,
          ),
          Text(item.description),
          SizedBox(
            height: 33.0,
          ),
          Text(
            "Features",
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildFeaturesView(item.features),
          SizedBox(
            height: 44.0,
          ),
          button
        ],
      ),
    );
  }
}
