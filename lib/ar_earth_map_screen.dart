import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArEarthMapScreen extends StatefulWidget {
  const ArEarthMapScreen({super.key});

  @override
  State<ArEarthMapScreen> createState() => _ArEarthMapScreenState();
}

class _ArEarthMapScreenState extends State<ArEarthMapScreen> {
  ArCoreController? augmentedRealityViewController;
  augmentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityViewController = coreController;
    displayEarthMapSpeher(augmentedRealityViewController!);
  }

  displayEarthMapSpeher(ArCoreController coreController) async {
    final ByteData earthTextureBytes =
        await rootBundle.load("image/earth_map.jpg");
    final materials = ArCoreMaterial(
        color: Colors.blue,
        textureBytes: earthTextureBytes.buffer.asUint8List());

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node =
        ArCoreNode(shape: sphere, position: vector64.Vector3(0, 0, -1.5));
    augmentedRealityViewController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}
