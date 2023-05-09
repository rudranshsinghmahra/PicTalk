import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pic_talk_app/views/name_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    speakTheText();
    _initializeTts();
    super.initState();
  }

  void _initializeTts() {
    flutterTts.setCompletionHandler(() {
      // Speech has finished
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NameScreen()));
    });
  }

  Future<void> speakTheText() async {
    List<dynamic> voices = await flutterTts.getVoices;
    int i = 0;
    for (dynamic voice in voices) {
      print("Voice name: ${voice['name']}");
      print("Voice identifier: ${voice['voiceId']}");
      print("Language: ${voice['language']}");
      print("Country: ${voice['country']}");
      print(i++);
      print(" ");
    }
    await flutterTts.setVoice({
      'name': voices[7]['name'],
      'locale': voices[7]['locale'],
    });
    String text =
        "Welcome to PicTalk. My job is to generate text and speech for images. Reading is hard but listening is easy. PicTalk lets you generate text and speech for anything you normally use like PDFs, email, images, books,and more.";
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14202e),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 130.0, left: 20, right: 20),
                  child: Text(
                    "Welcome to PicTalk. My job is to generate text and speech for images.",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Text(
                    "Reading is hard but listening is easy.",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Text(
                    "PicTalk lets you generate text and speech for anything you normally"
                    " use like PDFs, email, images, books, and more.",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/wave.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
