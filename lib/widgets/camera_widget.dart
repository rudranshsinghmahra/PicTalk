import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatelessWidget {
  final CameraController controller;

  CameraWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CameraPreview(controller);
  }
}