import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(widget.controller)),
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
                if (shownText != null) {
                  flutterTts.speak(shownText.toString());
                }
              });
            },
            child: const Icon(Icons.camera),
          ),
        ),
        if (shownText != null)
          GestureDetector(
            onTap: () {
              setState(() {
                shownText = null;
                flutterTts.stop();
              });
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.black45,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          shownText!.replaceAll('\n', " "),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
