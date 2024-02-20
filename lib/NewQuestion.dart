import 'package:flutter/material.dart';


void main() => runApp(const NewQuestionApp());

class NewQuestion {

  int iD = 0;
  String question = '';


  NewQuestion(String q) {
    question = q;
  }

}

class NewQuestionApp extends StatelessWidget {
  const NewQuestionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Colors.white, useMaterial3: true),
      title: 'Icon Button Types',
      home: const Scaffold(
        body: ToggleButtons(),
      ),
    );
  }
}

class ToggleButtons extends StatefulWidget {
  const ToggleButtons({super.key});

  @override
  State<ToggleButtons> createState() => NewQuestionState();
}


class NewQuestionState extends State<ToggleButtons> {

  bool standardSelected = false;
  bool standardSelected2 = false;
  bool standardSelected3 = false;
  bool standardSelected4 = false;
  bool standardSelected5 = false;



  @override
  Widget build(BuildContext context) {
    return Column();
  }
}