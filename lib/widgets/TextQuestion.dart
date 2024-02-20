import 'package:flutter/material.dart';
import 'FormVisualize.dart';

class SingleRowTextQuestion extends StatefulWidget {
  final Question question;
  final Function(String, dynamic) onSaveResponse;

  SingleRowTextQuestion({required this.question, required this.onSaveResponse});

  @override
  _SingleRowTextQuestionState createState() => _SingleRowTextQuestionState();
}

class _SingleRowTextQuestionState extends State<SingleRowTextQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: widget.question.question),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une valeur.';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        widget.onSaveResponse(widget.question.iD.toString(), value);
      },
    );
  }
}

class NumericTextQuestion extends StatefulWidget {
  final Question question;
  final Function(String, String) onSaveResponse;

  NumericTextQuestion({required this.question, required this.onSaveResponse});

  @override
  _NumericTextQuestionState createState() => _NumericTextQuestionState();
}

class _NumericTextQuestionState extends State<NumericTextQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: widget.question.question),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une valeur numérique.';
        }
        if (double.tryParse(value) == null) {
          return 'Veuillez entrer un nombre valide.';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        widget.onSaveResponse(widget.question.iD.toString(), value);
      },
    );
  }
}

class EmailTextQuestion extends StatefulWidget {
  final Question question;
  final Function(String, String) onSaveResponse;

  EmailTextQuestion({required this.question, required this.onSaveResponse});

  @override
  _EmailTextQuestionState createState() => _EmailTextQuestionState();
}

class _EmailTextQuestionState extends State<EmailTextQuestion> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: widget.question.question),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une adresse e-mail.';
        }
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Veuillez entrer une adresse e-mail valide.';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        widget.onSaveResponse(widget.question.iD.toString(), value);
      },
    );
  }
}
