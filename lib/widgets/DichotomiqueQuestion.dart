import 'package:flutter/material.dart';

class DichotomousQuestion {
  final int iD;
  final String question;

  DichotomousQuestion({
    required this.iD,
    required this.question,
  });
}

class DichotomousQuestionWidget extends StatefulWidget {
  final DichotomousQuestion question;
  final Function(String, dynamic) onSaveResponse;

  DichotomousQuestionWidget(
      {Key? key, required this.question, required this.onSaveResponse})
      : super(key: key);

  @override
  _DichotomousQuestionWidgetState createState() =>
      _DichotomousQuestionWidgetState();
}

class _DichotomousQuestionWidgetState extends State<DichotomousQuestionWidget> {
  String? _selectedOption;

  @override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.question.question,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Container(
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RadioListTile<String>(
                title: const Text('Oui'),
                value: 'Yes',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  widget.onSaveResponse(widget.question.iD.toString(), value);
                },
              ),
              RadioListTile<String>(
                title: const Text('Non'),
                value: 'No',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  widget.onSaveResponse(widget.question.iD.toString(), value);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  
}
