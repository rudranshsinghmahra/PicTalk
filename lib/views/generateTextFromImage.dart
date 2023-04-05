import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_widget.dart';

class TextFromImageScreen extends StatefulWidget {
  const TextFromImageScreen({super.key});

  @override
  State<TextFromImageScreen> createState() => _TextFromImageScreenState();
}

class _TextFromImageScreenState extends State<TextFromImageScreen> {
  late CameraController _controller;
  List<CameraDescription>? _cameras;

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller.initialize();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: FutureBuilder(
        future: _initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            child: CameraWidgetForTextToImage(
              controller: _controller,
            ),
          );
        },
      ),
    );
  }
}
