import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14202e),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 130.0, left: 20, right: 20),
              child: Text(
                "Welcome to PicTalk. My job is to generate text and speech for images",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Text(
                "Reading is hard but listening is easy",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Text(
                "PicTalk lets you generate text and speech for anything you normally"
                " use like PDFs, email, books,and more - with the most"
                " human-alike AI voice available anywhere",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
