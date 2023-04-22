import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pic_talk_app/views/emotion_detection_screen.dart';
import 'package:pic_talk_app/views/generateTextFromImage.dart';

import '../main.dart';
import 'ObjectDetectionScreen.dart';
import 'barcode_scanner_screen.dart';
import 'body_parts_detection_screen.dart';
import 'generateLabelsFromImage.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    welcomeWords();
    super.initState();
  }

  Future<void> welcomeWords() async {
    await flutterTts.speak(
        "Hey! ${widget.name} Welcome to PicTalk. What do you want PicTalk to help you do?");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14202e),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, right: 20.0, left: 20),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20.0, left: 20),
            child: Text(
              "What do you want PicTalk to help you do, ${widget.name}?",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              children: [
                customCard(
                  "assets/demo.png",
                  "Generate Text from Images",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextFromImageScreen(),
                    ),
                  ),
                ),
                customCard(
                  "assets/demo.png",
                  "Generate Image Labels",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LabelFromImage(),
                      ),
                    );
                  },
                ),
                customCard(
                  "assets/demo.png",
                  "Live Emotion from Images",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmotionDetectionScreen(),
                    ),
                  ),
                ),
                customCard(
                  "assets/demo.png",
                  "QR/Barcode Scanning",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScanPage(),
                    ),
                  ),
                ),
                customCard(
                  "assets/demo.png",
                  "Object Detection Screen",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ObjectDetectionScreen(cameras!),
                    ),
                  ),
                ),
                customCard(
                  "assets/demo.png",
                  "Body Parts Detection",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BodyPartsDetectionScreen(cameras!),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget customCard(img, String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
          intensity: 1,
          depth: 6,
          border: NeumorphicBorder(color: Colors.white54),
          shadowLightColor: Color.fromARGB(
            255,
            40,
            46,
            80,
          ),
          shadowDarkColor: Color.fromARGB(
            255,
            16,
            18,
            33,
          ),
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff1b2c40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
