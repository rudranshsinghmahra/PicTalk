import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pic_talk_app/main.dart';
import 'package:pic_talk_app/views/emotion_detection_screen.dart';
import 'package:pic_talk_app/views/generateLabelsFromImage.dart';

import 'ObjectDetectionScreen.dart';
import 'barcode_scanner_screen.dart';
import 'body_parts_detection_screen.dart';
import 'generateTextFromImage.dart';

class SelectionScreenSecond extends StatefulWidget {
  const SelectionScreenSecond({Key? key}) : super(key: key);

  @override
  State<SelectionScreenSecond> createState() => _SelectionScreenSecondState();
}

class _SelectionScreenSecondState extends State<SelectionScreenSecond> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    welcomeWords();
    super.initState();
  }

  Future<void> welcomeWords() async {
    List<dynamic> voices = await flutterTts.getVoices;
    for (dynamic voice in voices) {
      print("Voice name: ${voice['name']}");
      print("Voice identifier: ${voice['voiceId']}");
      print("Language: ${voice['language']}");
      print("Country: ${voice['country']}");
      print("");
    }
    await flutterTts.setVoice({
      'name': voices[5]['name'],
      'locale': voices[5]['locale'],
    });
    await flutterTts.speak(
        "Welcome back to PicTalk!. What do you want PicTalk to help you do?");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14202e),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 20.0, left: 20),
            child: Text(
              "Welcome back to PicTalk!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20.0, left: 20),
            child: Text(
              "What do you want PicTalk to help you do?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
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
                  "Extract Text from Images",
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
