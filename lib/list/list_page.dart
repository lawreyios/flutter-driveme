import 'package:flutter/material.dart';
import 'package:driveme/details/details_page.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/strings.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    ListBloc().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LIST_PAGE_TITLE),
        ),
        body: StreamBuilder<CarsList>(
          stream: ListBloc().outCars,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<CarsList> snapshot) {
            if (snapshot.hasError) {
              return _displayErrorMessage(snapshot.error.toString());
            } else if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data.errorMessage != null) {
              return _displayErrorMessage(snapshot.data.errorMessage);
            } else {
              return SingleChildScrollView(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  key: Key('car_list'),
                  children: snapshot.data.items.map((Car value) {
                    return _buildListRow(value);
                  }).toList(),
                ),
              );
            }
          },
        ));
  }

  Widget _displayErrorMessage(String errorMessage) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('Error: $errorMessage')));
  }

  Widget _buildListRow(Car item) {
    return Container(
        color: item.selected ? Colors.green.shade200 : Colors.white,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: (item.url == null || item.url.isEmpty)
                        ? Image.asset('assets/placeholder.png',
                            height: 150, fit: BoxFit.cover)
                        : Image.network(item.url,
                            height: 150, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "${item.pricePerDay}/day",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            onTap: () {
              _displayDetails(item);
            },
          ),
        ));
  }

  void _displayDetails(Car item) async {
    await Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return DetailsPage(id: item.id);
      },
    ));
  }
}
