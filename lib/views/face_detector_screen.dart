import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  File? _imageFile;
  List<Face>? _faces;
  bool isLoading = false;
  ui.Image? _image;

  Future getImage(bool isCamera) async {
    XFile? pickedFile;
    if (isCamera) {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      setState(() {
        _imageFile = image;
        isLoading = true;
      });
      detectFaces(_imageFile!);
    }
  }

  detectFaces(File imageFile) async {
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
      (value) => setState(() {
        _image = value;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Detector"),
        backgroundColor: const Color(0xff14202e),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (_imageFile == null)
              ? Center(child: Text('No image selected'))
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FittedBox(
                          child: SizedBox(
                            width: _image?.width.toDouble(),
                            height: _image?.height.toDouble(),
                            child: CustomPaint(
                              painter: FacePainter(_image!, _faces!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color(0xff14202e),
            onPressed: () {
              getImage(true);
            },
            tooltip: 'Camera',
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(
            height: 22.0,
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff14202e),
            heroTag: null,
            onPressed: () {
              getImage(false);
            },
            tooltip: 'Gallery',
            child: Icon(Icons.folder),
          ),
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
