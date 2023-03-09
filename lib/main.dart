import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pic_talk_app/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  CameraController controller =
      CameraController(cameras[0], ResolutionPreset.high);
  await controller.initialize();
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final CameraController controller;

  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PicTalk',
      home: SplashScreen(
        controller: controller,
      ),
    );
  }
}
