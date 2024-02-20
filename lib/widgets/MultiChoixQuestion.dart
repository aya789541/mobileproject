import 'package:flutter/material.dart';

class MultipleChoiceQuestion {
  final int iD;
  final String question;
  final List<String> options;

  MultipleChoiceQuestion({
    required this.iD,
    required this.question,
    required this.options,
  });
}

class MultipleChoiceQuestionWidget extends StatefulWidget {
  final MultipleChoiceQuestion question;
  final Function(String, dynamic) onSaveResponse;

  MultipleChoiceQuestionWidget(
      {Key? key, required this.question, required this.onSaveResponse})
      : super(key: key);

  @override
  _MultipleChoiceQuestionWidgetState createState() =>
      _MultipleChoiceQuestionWidgetState();
}

class _MultipleChoiceQuestionWidgetState
    extends State<MultipleChoiceQuestionWidget> {
  List<bool> _checkedOptions = [];

  @override
  void initState() {
    super.initState();
    _checkedOptions = List<bool>.filled(widget.question.options.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.question,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Column(
          children: widget.question.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;

            return CheckboxListTile(
              title: Text(option),
              value: _checkedOptions[index],
              onChanged: (bool? value) {
                setState(() {
                  _checkedOptions[index] = value ?? false;
                });
              },
            );
          }).toList(),
        ),

      ],
    );
  }
}
