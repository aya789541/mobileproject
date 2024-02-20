import 'package:flutter/material.dart';
import 'FormVisualize.dart';

class _VisualAnalog5 {
  String question = '';
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  int idNext = 0;

  _VisualAnalog5(String q, int next) {
    question = q;
    value1 = false;
    value2 = false;
    value3 = false;
    value4 = false;
    value5 = false;
    idNext = next;
  }
}

class VisualAnalog5Widget extends StatefulWidget {
  final Question question;
  final Function(String, dynamic) onSaveResponse;

  const VisualAnalog5Widget(
      {Key? key, required this.question, required this.onSaveResponse})
      : super(key: key);

  @override
  _VisualAna5State createState() => _VisualAna5State();
}

class _VisualAna5State extends State<VisualAnalog5Widget> {
  late bool standardSelected;
  late bool standardSelected2;
  late bool standardSelected3;
  late bool standardSelected4;
  late bool standardSelected5;

  @override
  void initState() {
    super.initState();
    standardSelected = false;
    standardSelected2 = false;
    standardSelected3 = false;
    standardSelected4 = false;
    standardSelected5 = false;
  }

  void updateResponse() {
    widget.onSaveResponse(widget.question.iD.toString(), {
      'value1': standardSelected,
      'value2': standardSelected2,
      'value3': standardSelected3,
      'value4': standardSelected4,
      'value5': standardSelected5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600.0),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.question.question),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(standardSelected
                      ? Icons.sentiment_very_dissatisfied
                      : Icons.sentiment_very_dissatisfied_outlined),
                  color: standardSelected ? Colors.red : Colors.black,
                  onPressed: () {
                    setState(() {
                      if(standardSelected2) {
                        standardSelected2 = !standardSelected2;
                      } else {
                        if(standardSelected3) {
                        standardSelected3 = !standardSelected3;
                        } else {
                          if(standardSelected4) {
                          standardSelected4 = !standardSelected4;
                          } else {
                            if(standardSelected5) {
                            standardSelected5 = !standardSelected5;
                            } 
                          }
                        }
                      }
                      standardSelected = !standardSelected;
                      updateResponse();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(standardSelected2
                      ? Icons.sentiment_dissatisfied
                      : Icons.sentiment_dissatisfied_outlined),
                  color: standardSelected2 ? Colors.orange : Colors.black,
                  onPressed: () {
                    setState(() {
                      if(standardSelected) {
                        standardSelected = !standardSelected;
                      } else {
                        if(standardSelected3) {
                        standardSelected3 = !standardSelected3;
                        } else {
                          if(standardSelected4) {
                          standardSelected4 = !standardSelected4;
                          } else {
                            if(standardSelected5) {
                            standardSelected5 = !standardSelected5;
                            } 
                          }
                        }
                      }
                      standardSelected2 = !standardSelected2;
                      updateResponse();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(standardSelected3
                      ? Icons.sentiment_neutral
                      : Icons.sentiment_neutral_outlined),
                  color: standardSelected3 ? Colors.yellow : Colors.black,
                  onPressed: () {
                    setState(() {
                      if(standardSelected) {
                        standardSelected = !standardSelected;
                      } else {
                        if(standardSelected2) {
                        standardSelected2 = !standardSelected2;
                        } else {
                          if(standardSelected4) {
                          standardSelected4 = !standardSelected4;
                          } else {
                            if(standardSelected5) {
                            standardSelected5 = !standardSelected5;
                            } 
                          }
                        }
                      }
                      standardSelected3 = !standardSelected3;
                      updateResponse();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(standardSelected4
                      ? Icons.sentiment_satisfied
                      : Icons.sentiment_satisfied_outlined),
                  color: standardSelected4 ? Colors.lightGreen : Colors.black,
                  onPressed: () {
                    setState(() {
                      if(standardSelected) {
                        standardSelected = !standardSelected;
                      } else {
                        if(standardSelected2) {
                        standardSelected2 = !standardSelected2;
                        } else {
                          if(standardSelected3) {
                          standardSelected3 = !standardSelected3;
                          } else {
                            if(standardSelected5) {
                            standardSelected5 = !standardSelected5;
                            } 
                          }
                        }
                      }
                      standardSelected4 = !standardSelected4;
                      updateResponse();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(standardSelected5
                      ? Icons.sentiment_very_satisfied
                      : Icons.sentiment_very_satisfied_outlined),
                  color: standardSelected5 ? Colors.green : Colors.black,
                  onPressed: () {
                    setState(() {
                      if(standardSelected) {
                        standardSelected = !standardSelected;
                      } else {
                        if(standardSelected2) {
                        standardSelected2 = !standardSelected2;
                        } else {
                          if(standardSelected3) {
                          standardSelected3 = !standardSelected3;
                          } else {
                            if(standardSelected4) {
                            standardSelected4 = !standardSelected4;
                            } 
                          }
                        }
                      }
                      standardSelected5 = !standardSelected5;
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
