import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_widget.dart';

class TextFromImageScreen extends StatelessWidget {
  final CameraController controller;

  const TextFromImageScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14202e),
      appBar: AppBar(
        backgroundColor: const Color(0xff14202e),
        elevation: 0,
        centerTitle: true,
        title: const Text('Generate Text From Image(s)'),
      ),
      body: Center(
        child: SizedBox(
          child: CameraWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
