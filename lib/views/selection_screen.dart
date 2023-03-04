import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 100, right: 20.0, left: 20),
                  child: Text(
                    "What do you want PicTalk to help you do, ${widget.name}?",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              customCard("assets/demo.png", "Generate Caption from Image"),
              customCard("assets/demo.png", "Generate Caption from Image"),
              customCard("assets/demo.png", "Generate Caption from Image"),
              customCard("assets/demo.png", "Generate Caption from Image"),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff828bf5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () async {},
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customCard(img, String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff1b2c40),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
