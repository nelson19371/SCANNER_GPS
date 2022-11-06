import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.location_on),
            onPressed: () {
              getLocation();
            }),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      'Latitud',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('${_locationData.latitude}')
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      'Longitud',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('${_locationData.longitude}')
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      'Altitud',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('${_locationData.altitude}')
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      'Dirección',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('${_locationData.heading}')
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      print('${_locationData.altitude}');
      print('${_locationData.latitude}');
      print('${_locationData.longitude}');
    });
  }
}
