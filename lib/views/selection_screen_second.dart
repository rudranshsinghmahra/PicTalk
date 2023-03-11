import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pic_talk_app/views/generateLabelsFromImage.dart';

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
    await flutterTts.speak(
        "Welcome back to PicTalk!. What do you want PicTalk to help you do?");
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
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 100, right: 20.0, left: 20),
                  child: Text(
                    "Welcome back to PicTalk!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, right: 20.0, left: 20),
                  child: Text(
                    "What do you want PicTalk to help you do?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              customCard(
                  "assets/demo.png",
                  "Generate Text from Images",
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextFromImageScreen(),
                        ),
                      )),
              customCard("assets/demo.png", "Generate Image Labels", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabelFromImage(),
                  ),
                );
              }),
              // customCard("assets/demo.png", "Generate Caption from Image"),
              // customCard("assets/demo.png", "Generate Caption from Image"),
            ],
          ),
        ],
      ),
    );
  }

  Widget customCard(img, String title, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }
}
