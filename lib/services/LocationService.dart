import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = new Location();
  LocationData? locationData;

  bool isLoaded = false;

  void _initializeCallback() async {
    if (isLoaded) location.onLocationChanged.listen((LocationData currentLocation) {
      locationData = currentLocation;
    });
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

    isLoaded = true;

    _initializeCallback();
  }
}
