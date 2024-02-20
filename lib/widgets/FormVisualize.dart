import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'VisualAnalog5.dart';
import 'VisualAnalog2.dart';
import 'matrix_question.dart';
import 'MultiChoixQuestion.dart';
import "DichotomiqueQuestion.dart";
import "TextQuestion.dart";
import "endpage.dart";
import 'semantic_scale.dart';
import '../SharedData.dart';
class Question {
  int iD;
  String type;
  String question;
  Map<String, dynamic> spec;
  int next;

  Question({
    required this.iD,
    required this.type,
    required this.question,
    required this.spec,
    required this.next,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      iD: json['iD'],
      type: json['type'],
      question: json['question'],
      spec: json['spec'],
      next: json['next'],
    );
  }
}

class FormVisualize {
  late String user;
  late String title;
  late List<Question> questions;
  late String userId;

  FormVisualize(String json, this.userId) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    user = jsonMap['userID']; // Use 'userID' instead of 'user'
    title = jsonMap['title'];
    questions = (jsonMap['questions'] as List?)
            ?.map((questionJson) => Question.fromJson(questionJson))
            .toList() ??
        [];
  }
}

class FormVisualizeApp extends StatelessWidget {
  final String userId; // Ajout de l'ID utilisateur en tant qu'argument
  const FormVisualizeApp({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale de l'application
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Autres styles et thèmes à personnaliser selon les préférences
      ),
      title: 'Formulaire d\'enquête',
      home: FutureBuilder<String>(
        future: readJsonFile(SharedData.quest),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, check for errors
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Use the snapshot.data, which is the result of the Future
              FormVisualize form = FormVisualize(snapshot.data ?? '', userId);
              return Scaffold(
                appBar: AppBar(
                  title: Text(form.title),
                  centerTitle: true,
                ),
                body: FormVisualizeState(
                  jsonhere: snapshot.data ?? '',
                  userId: userId, // Ajoutez cette ligne
                ),
              );
            }
          } else {
            // While the Future is still running, show a loading indicator or placeholder
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<String> readJsonFile(String path) async {
    try {
      // Replace 'path/to/your/file.json' with the actual path to your JSON file
      String contents =
          await rootBundle.loadString("assets/"+SharedData.quest);
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

Widget detectType(
    var question, Function(String, dynamic) saveResponse, String userId) {
  switch (question.type) {
    case "dichotomique":
      // Crée une instance de DichotomousQuestion à partir des données de la question
      DichotomousQuestion dichotomousQuestion = DichotomousQuestion(
        iD: question.iD,
        question: question.question,
      );
      // Utilisez le widget DichotomousQuestionWidget avec l'instance de DichotomousQuestion
      return DichotomousQuestionWidget(
        question: dichotomousQuestion,
        onSaveResponse: (id, response) => saveResponse(id, response),
      );

    // Autres cas existants..
    case "choice":
      // Crée une instance de MultipleChoiceQuestion à partir des données de la question
      MultipleChoiceQuestion multipleChoiceQuestion = MultipleChoiceQuestion(
        iD: question.iD,
        question: question.question,
        options: question.spec['options'].cast<String>(),
      );
      // Utilisez le widget MultipleChoiceQuestionWidget avec l'instance de MultipleChoiceQuestion
      return MultipleChoiceQuestionWidget(
        question: multipleChoiceQuestion,
        onSaveResponse: (id, response) => saveResponse(id, response),
      );

    case "analog":
      if (question.spec['subtype'] == 2) {
        return VisualAnalog2Widget(
          question: question,
          onSaveResponse: (id, response) => saveResponse(id, response),
        );
      } else if (question.spec['subtype'] == 5) {
        return VisualAnalog5Widget(
          question: question,
          onSaveResponse: (id, response) => saveResponse(id, response),
        );
      }
      break;
    /* case "semantic":
      return SliderForm(
        question: question,
        onSaveResponse: (id, response) => saveResponse(id, response),
        userId:
            userId, // Passer userId comme paramètre // Assurez-vous que l'ID utilisateur est disponible dans le widget
      );*/

    case "matrix":
      // Créez une instance de MatrixQuestion à partir des données de la question
      MatrixQuestion matrixQuestion = MatrixQuestion(
        iD: question.iD,
        question: question.question,
        spec: question.spec,
        next: question.next,
      );
      // Utilisez le MatrixQuestionWidget avec l'instance de MatrixQuestion
      return MatrixQuestionWidget(
        question: matrixQuestion,
        onSaveResponse: (id, response) => saveResponse(id, response),
      );
    case "text":
      final subtype = question.spec?['subtype'] as String? ?? 'singleRow';

      switch (subtype) {
        case 'singleRow':
          return SingleRowTextQuestion(
            question: question,
            onSaveResponse: (id, response) => saveResponse(id, response),
          );
        case 'numeric':
          return NumericTextQuestion(
            question: question,
            onSaveResponse: (id, response) => saveResponse(id, response),
          );
        case 'email':
          return EmailTextQuestion(
            question: question,
            onSaveResponse: (id, response) => saveResponse(id, response),
          );
        default:
          return SingleRowTextQuestion(
            question: question,
            onSaveResponse: (id, response) => saveResponse(id, response),
          );
      }
  }
  return const Text("Coucou");
}

List<Widget> createForm(
    FormVisualize form, Function(String, dynamic) saveResponse, String userId) {
  List<Widget> widgetList = [];
  for (var q in form.questions) {
    var res = detectType(q, saveResponse, userId); // Ajout de userId ici
    widgetList.add(res);
  }
  return widgetList;
}

class FormVisualizeState extends StatefulWidget {
  final String jsonhere;
  final String userId; // Ajouter cette ligne

  const FormVisualizeState(
      {Key? key, required this.jsonhere, required this.userId})
      : super(key: key); // Modifier cette ligne

  @override
  _FormVisualizeState createState() => _FormVisualizeState();
}

class _FormVisualizeState extends State<FormVisualizeState> {
  late FormVisualize form;
  int currentQuestionIndex = 0;
  int nextQuestionID = 1;
  Map<String, dynamic> responses = {};

  @override
  void initState() {
    super.initState();
    form = FormVisualize(widget.jsonhere, widget.userId);
    currentQuestionIndex = 0;
  }

  void saveResponse(String questionId, dynamic response) {
    setState(() {
      responses[questionId] = response;
      FirebaseFirestore.instance.collection('responses').doc(questionId).set({
        'userId': widget.userId,
        'response': response,
      });
    });
  }

  Future<void> saveResponsesAsJSON() async {
    try {
      // Convertissez toutes les instances de Set en List
      final Map<String, dynamic> encodableResponses = {};
      responses.forEach((key, value) {
        if (value is Set) {
          encodableResponses[key] = value.toList();
        } else {
          encodableResponses[key] = value;
        }
      });

      String jsonResponses = jsonEncode(encodableResponses);
      await FirebaseFirestore.instance.collection('jsonResponses').add({
        'userId': widget.userId,
        'data': jsonResponses,
      });
    } catch (e) {
      print(
          'Erreur lors de l\'encodage JSON ou de l\'enregistrement dans Firestore: $e');
    }
  }

  Future<void> goToNextQuestion(int nextQuestionID) async {
    if (nextQuestionID == -1) {
      await saveResponsesAsJSON();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EndPage(
            responses: responses,
            userId: widget.userId,
          ),
        ),
      );
    } else {
      setState(() {
        currentQuestionIndex =
            form.questions.indexWhere((q) => q.iD == nextQuestionID);
      });
    }
  }

  void goToPreviousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        // Sauvegarde de la réponse lors de la navigation vers la question précédente
        saveResponse(
          form.questions[currentQuestionIndex].iD.toString(),
          responses[form.questions[currentQuestionIndex].iD.toString()],
        );
        currentQuestionIndex--;
      }
    });
  }

@override
  Widget build(BuildContext context) {
    List<Widget> widgetList = createForm(
      form,
      saveResponse,
      widget.userId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1} of ${form.questions.length}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline), // Ajoutez une icône d'aide
            onPressed: () {
              // Affichez des instructions ou une boîte de dialogue d'aide
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Instructions'),
                    content: Text('Instructions pour remplir le formulaire...'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            widgetList[currentQuestionIndex],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                nextQuestionID = form.questions[currentQuestionIndex].next;
            if (nextQuestionID > -1) {
              goToNextQuestion(nextQuestionID);
            } else if (nextQuestionID == -1) {
              saveResponse(
                  form.questions[currentQuestionIndex].iD.toString(),
                  responses[
                      form.questions[currentQuestionIndex].iD.toString()]);
              await goToNextQuestion(nextQuestionID);
            }
              },
              child: Text(
                (form.questions[currentQuestionIndex].next == -1)
                    ? "Envoyer la réponse"
                    : "Suivant",
              ),
            ),
            SizedBox(height: 10),
            if (currentQuestionIndex > 0)
              ElevatedButton(
                onPressed: () async {
                  goToPreviousQuestion();
              await saveResponsesAsJSON();
                },
                child: Text("Précédent"),
              ),
          ],
        ),
      ),
    );
  }
}
