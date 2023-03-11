import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class LabelFromImage extends StatefulWidget {
  const LabelFromImage({Key? key}) : super(key: key);

  @override
  State<LabelFromImage> createState() => _LabelFromImageState();
}

class _LabelFromImageState extends State<LabelFromImage> {
  bool imageLabelChecking = false;
  XFile? imageFile;
  String imageLabel = "";
  FlutterTts flutterTts = FlutterTts();
  ImagePicker? _picker;

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedImage = await _picker?.pickImage(source: source);
      if (pickedImage != null) {
        imageLabelChecking = true;
        imageFile = pickedImage;
        imageLabel = "";
        setState(() {});
        getImageLabels(pickedImage);
      }
    } catch (e) {
      imageLabelChecking = false;
      imageFile = null;
      imageLabel = "Error occurred while getting image label";
      setState(() {});
    }
  }

  Future<void> getImageLabels(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    ImageLabeler imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.7));
    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    StringBuffer stringBuffer = StringBuffer();
    for (ImageLabel imageLabel in labels) {
      String labelText = imageLabel.label;
      flutterTts.speak(labelText);
      await Future.delayed(const Duration(seconds: 1));
      double confidence = imageLabel.confidence;
      stringBuffer.write(labelText);
      stringBuffer.write(" : ");
      stringBuffer.write((confidence * 100).toStringAsFixed(2));
      stringBuffer.write("%\n");
    }
    imageLabeler.close();
    imageLabel = stringBuffer.toString();
    imageLabelChecking = false;
    setState(() {});
  }

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    _picker = null;
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
        title: const Text('Generate Labels From Image(s)'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageLabelChecking)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            if (!imageLabelChecking && imageFile == null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  height: imageLabel == ""
                      ? MediaQuery.of(context).size.height * 0.6
                      : MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: const Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: Colors.grey,
                    size: 200,
                  ),
                ),
              ),
            if (imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      CupertinoIcons.photo,
                    ),
                    iconSize: 50,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    icon: const Icon(
                      CupertinoIcons.camera,
                    ),
                    iconSize: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        imageLabel,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
