import 'package:flutter/material.dart';

import 'FormVisualize.dart';

// void main() => runApp(const SliderApp());

// class SliderApp extends StatelessWidget {
//   const SliderApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: SliderForm(),
//     );
//   }
// }

class _SliderClass {
  String question = '';
  double min = 0;
  double max = 1;
  int div = 1;
  int idNext = 0;

  _SliderClass(String q, double mini, double maxi, int divi, int next) {
    question = q;
    max = maxi;
    min = mini;
    div = divi;
    idNext = next;
  }
}

class SliderForm extends StatefulWidget {
  final Question question;
  final Function(String, dynamic) onSaveResponse;
  final String userId;
  const SliderForm({
    super.key,
    required this.question,
    required this.onSaveResponse,
    required this.userId,
  });
  State<SliderForm> createState() => _SliderFormState();
}

class _SliderFormState extends State<SliderForm> {
  late double _currentSliderValue;
  late _SliderClass questionSlider;

  @override
  void initState() {
    super.initState();
    // Initialize your state variables here based on widget.question
    _currentSliderValue = widget.question.spec['min'];
    questionSlider = _SliderClass(
        widget.question.question,
        widget.question.spec['min'],
        widget.question.spec['max'],
        widget.question.spec['div'],
        widget.question.next);
  }

  void updateResponse(double value) {
    setState(() {
      _currentSliderValue = value;
      // Appelle onSaveResponse avec l'ID de la question et la valeur actuelle
      widget.onSaveResponse(widget.question.iD.toString(), value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(maxWidth: 600.0),
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
          margin: const EdgeInsets.all(8.0), // Adjust the margin as needed
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.black), // Add border for the box shape
            borderRadius: BorderRadius.circular(
                10.0), // Adjust the border radius as needed
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(widget.question.question),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.question.spec['min'].toString()),
                // const SizedBox(width: 5),
                Container(
                  width: 400,
                  child: SliderTheme(
                    data: const SliderThemeData(
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: Slider(
                      value: _currentSliderValue,
                      min: questionSlider.min,
                      max: questionSlider.max,
                      divisions: questionSlider.div,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ),
                // const SizedBox(width: 5),
                Text(widget.question.spec['max'].toString()),
              ],
            )
          ])),
    );
  }
}
