import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pic_talk_app/main.dart';
import 'package:progresso/progresso.dart';
import 'package:tflite/tflite.dart';

class EmotionDetectionScreen extends StatefulWidget {
  const EmotionDetectionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionDetectionScreen> createState() => _EmotionDetectionScreenState();
}

class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> {
  CameraController? _controller;
  CameraImage? cameraImage;
  String output = '';
  double confidence = 0.0;
  bool backCameraSelected = true;
  bool isRunningModel = false;

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _controller = CameraController(
        cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize().then((value) {
        if (!mounted) {
          return;
        } else {
          setState(() {
            _controller!.startImageStream((imageStream) {
              cameraImage = imageStream;
              if (!isRunningModel) {
                isRunningModel = true;
                runModel();
              }
            });
          });
        }
      });
    }
  }

  runModel() async {
    if (cameraImage != null) {
      var prediction = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      prediction?.forEach((element) {
        if (mounted) {
          setState(() {
            confidence = element['confidence'];
            output = element['label'].toString();
            isRunningModel = false;
          });
        }
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      numThreads: 2,
    );
  }

  @override
  void initState() {
    _initializeCamera();
    loadModel();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
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
        title: const Text('Live Emotion From Image(s)'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _controller?.value.isInitialized ?? false
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CameraPreview(_controller!)),
                    ),
                  )
                : Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: Row(
              children: [
                Text(
                  output,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Progresso(
                      backgroundStrokeWidth: 20,
                      progress: confidence,
                      progressColor: Color(0xff7949f0),
                      backgroundColor: Color(0xfff2effa),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
