import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:convert';
import 'package:flutter/services.dart';

// void main() {
//   runApp(const FormApp());
// }

class FormApp extends StatelessWidget {
  const FormApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Read JSON File Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              readJsonFile('lib/questionnaires/questionnaire.json');
            },
            child: const Text('Read JSON File'),
          ),
        ),
      ),
    );
  }

  Future<String> readJsonFile(String path) async {
    try {
      // Replace 'path/to/your/file.json' with the actual path to your JSON file
      String contents = await rootBundle.loadString(path);
      return contents;

      // Now you have the JSON contents as a string
      // print(contents);

      // You can decode the JSON string to a Dart object if needed
      // Map<String, dynamic> jsonMap = json.decode(contents);
      // print(jsonMap);
    } catch (e) {
      print('Error reading JSON file: $e');
      return 'Error reading JSON file: $e';
    }
  }
}
