import 'package:flutter/material.dart';
import 'FormVisualize.dart';

class _VisualAnalog2 {
  String question = '';
  bool value1 = false;
  bool value2 = false;
  int idNext = 0;

  _VisualAnalog2(String q, int next) {
    question = q;
    value1 = false;
    value2 = false;
    idNext = next;
  }
}

class VisualAnalog2Widget extends StatefulWidget {
  final Question question;
  final Function(String, dynamic) onSaveResponse;

  const VisualAnalog2Widget(
      {Key? key, required this.question, required this.onSaveResponse})
      : super(key: key);

  @override
  _VisualAna2State createState() => _VisualAna2State();
}

class _VisualAna2State extends State<VisualAnalog2Widget> {
  late bool standardSelected;
  late bool standardSelected2;
  late _VisualAnalog2 questionAnalogue;

  @override
  void initState() {
    super.initState();
    standardSelected = false;
    standardSelected2 = false;
    questionAnalogue =
        _VisualAnalog2(widget.question.question, widget.question.next);
  }

  void updateResponse() {
    widget.onSaveResponse(widget.question.iD.toString(),
        {'value1': standardSelected, 'value2': standardSelected2});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // ... Existing Container setup ...
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.question.question),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(standardSelected
                      ? Icons.thumb_up
                      : Icons.thumb_up_outlined),
                  onPressed: () {
                    setState(() {
                      standardSelected = !standardSelected;
                      if (standardSelected2) standardSelected2 = false;
                      updateResponse();
                    });
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(standardSelected2
                      ? Icons.thumb_down
                      : Icons.thumb_down_outlined),
                  onPressed: () {
                    setState(() {
                      standardSelected2 = !standardSelected2;
                      if (standardSelected) standardSelected = false;
                      updateResponse();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
