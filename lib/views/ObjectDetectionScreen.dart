import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pic_talk_app/models.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';

class ObjectDetectionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  ObjectDetectionScreen(this.cameras);

  @override
  _ObjectDetectionScreenState createState() =>
      new _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = ssd;

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  loadModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
    print(res);
  }

  // loadModel() async {
  //   String? res;
  //   switch (_model) {
  //     case yolo:
  //       res = await Tflite.loadModel(
  //         model: "assets/yolov2_tiny.tflite",
  //         labels: "assets/yolov2_tiny.txt",
  //       );
  //       break;
  //
  //     case mobilenet:
  //       res = await Tflite.loadModel(
  //           model: "assets/mobilenet_v1_1.0_224.tflite",
  //           labels: "assets/mobilenet_v1_1.0_224.txt");
  //       break;
  //
  //     case posenet:
  //       res = await Tflite.loadModel(
  //           model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
  //       break;
  //
  //     default:
  //       res = await Tflite.loadModel(
  //           model: "assets/ssd_mobilenet.tflite",
  //           labels: "assets/ssd_mobilenet.txt");
  //   }
  //   print(res);
  // }

  // onSelect(model) {
  //   setState(() {
  //     _model = model;
  //   });
  //   loadModel();
  // }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff14202e),
        title: Text("Object Detection"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          _recognitions.isNotEmpty
              ? BndBox(
                  _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model)
              : Container(),
        ],
      ),
    );
  }
}
