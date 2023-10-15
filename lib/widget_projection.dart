import 'package:Rewind/services/LocationService.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:provider/provider.dart';

class TapPage extends StatefulWidget {
  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  late ARKitController arkitController;
  ARKitSphere? sphere;

  Location location = new Location();
  LocationData? locationData;

  bool isLoaded = false;



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


    print("lat ${locationData!.latitude}");
    print("long ${locationData!.longitude}");
    print("alt ${locationData!.altitude}");
    print("heading ${locationData!.heading}");


    // flutter: lat 33.77816453570224
    // flutter: long -84.4050418037611
    // flutter: alt 298.62220001220703

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    initializeLocation();
    super.initState();
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);

    final material =
    ARKitMaterial(diffuse: ARKitMaterialProperty.color(Colors.yellow));
    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );


    final node = ARKitNode(
      name: 'sphere',
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );
    this.arkitController.add(node);
  }

  void onNodeTapHandler(List<String> nodesList) {
    final name = nodesList.first;
    final color =
    (sphere!.materials.value!.first.diffuse as ARKitMaterialColor).color ==
        Colors.yellow
        ? Colors.blue
        : Colors.yellow;
    sphere!.materials.value = [
      ARKitMaterial(diffuse: ARKitMaterialProperty.color(color))
    ];
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('You tapped on $name')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [new Color(0xCC000000), Colors.transparent])
      ),
      child: Center(
        child: (isLoaded) ? ARKitSceneView(
          enableTapRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ) : CircularProgressIndicator(),
      )
    );
  }
}