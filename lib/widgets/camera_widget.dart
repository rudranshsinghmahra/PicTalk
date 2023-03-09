import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pic_talk_app/api/TextRecognitionApi.dart';

class CameraWidget extends StatefulWidget {
  final CameraController controller;

  const CameraWidget({super.key, required this.controller});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  String? shownText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CameraPreview(widget.controller),
        Positioned(
          bottom: 50,
          child: FloatingActionButton(
            onPressed: () async {
              final image = await widget.controller.takePicture();
              final recognizedText = await TextRecognitionApi.recogonizeText(
                InputImage.fromFile(
                  File(image.path),
                ),
              );
              setState(() {
                shownText = recognizedText;
              });
            },
            child: const Icon(Icons.translate),
          ),
        ),
        if (shownText != null)
          Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.black45,
              child: Text(
                shownText!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
