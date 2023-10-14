import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Location location = new Location();
  LocationData? locationData;

  bool isLoaded = false;

  @override
  void initState() {
    initializeLocation();
    super.initState();
  }

  void initializeLocation() async {

    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;

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

    locationData = await location.getLocation();

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        locationData = currentLocation;
      });
    });
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLoaded ? "Lat: ${locationData?.latitude}" : "",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          Text(
            isLoaded ? "Long: ${locationData?.longitude}" : "",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          Text(
            isLoaded ? "Altitude: ${locationData?.altitude}" : "",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      )
    );
  }
}
