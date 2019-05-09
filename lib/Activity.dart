import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Activity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Activity();
  }
}

class _Activity extends State<Activity> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onCreateAr,
        enableTapRecognizer: true,
      ),
    );
  }

  _onCreateAr(ArCoreController controller) {
    arCoreController = controller;
    _createEarth(controller);
  }

  _createEarth(ArCoreController controller) {
    final material = ArCoreMaterial(
      reflectance: 1.0,
        color: Color.fromARGB(120, 66, 134, 244),texture: "assets/earth.png");
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreRotatingNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1),
      degreesPerSecond: 2,
      scale: vector.Vector3(0.2, 0.2, 0.4)
    );
    arCoreController.addArCoreNode(node);
  }

  _createShape(ArCoreController controller) {
    final material = ArCoreMaterial(color: Colors.blueAccent, metallic: 1);
    final cubematerial = ArCoreMaterial(color: Colors.green, metallic: 1);
    final sphere = ArCoreSphere(materials: [material], radius: 0.1);
    final cube = ArCoreCube(
        size: vector.Vector3(0.2, 0.3, 0.4), materials: [cubematerial]);
    final cubeNode = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0, 0, -2),
    );

    final node = ArCoreRotatingNode(
      shape: sphere,
      name: "node",
      degreesPerSecond: 2,
      scale: vector.Vector3(0.1, 0.9, 0.3),
      position: vector.Vector3(0, 0, -1),
    );
  }
    @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
