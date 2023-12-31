import 'package:Rewind/models/Memory.dart';
import 'package:Rewind/services/FirestoreService.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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

    // far away north
    // flutter: lat 33.778164805951874
    // flutter: long -84.40504231234652
    // flutter: alt 297.3958206176758

    //far away east
    // flutter: lat 33.778164411284926
    // flutter: long -84.40504197497975
    // flutter: alt 299.05274200439453

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

    Provider.of<FirestoreService>(context, listen: false).getMemories().forEach(
        (mem) => loadPost(mem)
    );
  }

  void loadPost(Memory mem) {
    final material =
        ARKitMaterial(diffuse: ARKitMaterialProperty.color(Colors.yellow));
    sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    double lat_dif = mem.lat - locationData!.latitude!;
    double long_dif = mem.long - locationData!.longitude!;

    double lat_num = lat_dif / -2.5;
    double long_num = long_dif / 2.5;

    final node = ARKitNode(
      name: mem.preview,
      geometry: sphere,
      position: vector.Vector3(long_dif / long_num, 0, lat_dif / lat_num),
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
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.white,
              content: Container(
                height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 18,
                                    backgroundImage:
                                        AssetImage('assets/images/pfp.jpg')),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    "Andre Koga",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(name),
                    ],
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [new Color(0xCC000000), Colors.transparent])),
        child: Center(
          child: (isLoaded)
              ? ARKitSceneView(
                  enableTapRecognizer: true,
                  onARKitViewCreated: onARKitViewCreated,
                )
              : CircularProgressIndicator(),
        ));
  }
}
