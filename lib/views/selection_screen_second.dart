import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pic_talk_app/main.dart';
import 'package:pic_talk_app/views/emotion_detection_screen.dart';
import 'package:pic_talk_app/views/face_detector_screen.dart';
import 'package:pic_talk_app/views/generateLabelsFromImage.dart';
import 'package:pic_talk_app/views/sign_language_detection.dart';
import 'package:pic_talk_app/views/splash_screen.dart';

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
  User? user = FirebaseAuth.instance.currentUser;

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
      appBar: AppBar(
        backgroundColor: const Color(0xff14202e),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20.0, left: 20),
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
                  false,
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
                  false,
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
                  false,
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
                  false,
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
                  false,
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
                  false,
                ),
                customCard(
                  "assets/demo.png",
                  "Face Detection",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FaceDetectionScreen(),
                      ),
                    );
                  },
                  false,
                  // () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BodyPartsDetectionScreen(cameras!),
                  //   ),
                  // ),
                ),
                customCard("assets/demo.png", "Sign Language Identification",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignLanguageDetection(),
                    ),
                  );
                }, false
                    // () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BodyPartsDetectionScreen(cameras!),
                    //   ),
                    // ),
                    ),
                customCard(
                    "assets/demo_2.png", "Selfie Segmentation", () {}, true
                    // () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BodyPartsDetectionScreen(cameras!),
                    //   ),
                    // ),
                    ),
                customCard(
                    "assets/demo_2.png", "On-Device Translation", () {}, true
                    // () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BodyPartsDetectionScreen(cameras!),
                    //   ),
                    // ),
                    ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${user?.displayName}"),
              accountEmail: Text("${user?.email}"),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  "${user?.photoURL}",
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff14202e),
              ),
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget customCard(img, String title, Function()? onTap, bool isDisabled) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
          intensity: 1,
          depth: isDisabled ? 2.5 : 6,
          border: NeumorphicBorder(color: Colors.white54),
          shadowLightColor: isDisabled
              ? Colors.grey.shade500
              : Color.fromARGB(
                  255,
                  40,
                  46,
                  80,
                ),
          shadowDarkColor: isDisabled
              ? Colors.grey
              : Color.fromARGB(
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
            color: isDisabled ? Colors.grey.shade400 : Color(0xff1b2c40),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDisabled ? Colors.grey.shade600 : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
