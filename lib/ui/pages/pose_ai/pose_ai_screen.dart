import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:vitaflow/ui/pages/pose_ai/render_data_arm_press.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

class PoseAiScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;

  const PoseAiScreen({super.key, required this.cameras, required this.title});

  @override
  State<PoseAiScreen> createState() => _PoseAiScreenState();
}

class _PoseAiScreenState extends State<PoseAiScreen> {
  List<dynamic>? _data;
  int _imageHeight = 0;
  int _imageWidth = 0;
  int x = 1;

  @override
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
  }

  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _data = data;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  loadModel() async {
    return await Tflite.loadModel(
        model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite");
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('AlignAI Arm Press'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Camera(
            cameras: widget.cameras,
            setRecognitions: _setRecognitions,
          ),
          RenderDataArmPress(
            data: _data ?? [],
            previewH: max(_imageHeight, _imageWidth),
            previewW: min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
          ),
        ],
      ),
    );
  }
}
