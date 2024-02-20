import 'package:flutter/material.dart';
import 'package:flutter_gform/home.dart'; // Assurez-vous que le chemin d'importation est correct
import 'dart:math' as math;
import 'package:flutter_gform/flutter_app/app_home_screen.dart';

class EndPage extends StatefulWidget {
  final Map<String, dynamic> responses;
  final String userId;

  const EndPage({Key? key, required this.responses, required this.userId})
      : super(key: key);

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _percentage;
  late double
      _progressValue; // Pourcentage de progression pour l'affichage dans le cercle

  @override
  void initState() {
    super.initState();
    int totalQuestions = 10; // Nombre total de questions fixé à 10
    int answeredQuestions =
        widget.responses.values.where((r) => r != null && r != '').length;
    _percentage = (answeredQuestions / totalQuestions) * 100;
    _progressValue = answeredQuestions /
        totalQuestions; // Calcul de la valeur de progression

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: _progressValue).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.checklist_rtl,
                color: Colors.black), // Icône à côté du texte
            SizedBox(width: 8), // Espace entre l'icône et le texte
            Text('Récapitulatif du Questionnaire',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 22)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Progression totale",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _animation.value,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 197, 143, 199)),
                    strokeWidth: 10,
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.4, 0.6, 1.0],
                    ),
                  ),
                ),
                Text(
                  '${(_percentage).toInt()}%',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.responses.length,
                itemBuilder: (context, index) {
                  String questionKey = 'Question ${index + 1}';
                  dynamic response = widget.responses.values.elementAt(index);
                  Icon responseIcon = Icon(Icons.question_answer,
                      color: Color.fromARGB(255, 197, 178, 197));

                  // Déterminez l'icône à afficher en fonction de la réponse
                  if (response == true) {
                    responseIcon =
                        Icon(Icons.check_circle, color: Colors.green);
                  } else if (response == false) {
                    responseIcon = Icon(Icons.remove_circle, color: Colors.red);
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: responseIcon,
                      title: Text(questionKey,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(response?.toString() ?? 'No response',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600])),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FitnessAppHomeScreen(
                        userId: widget
                            .userId), // Assurez-vous que la classe HomeScreen est correctement importée et utilisable.
                  ),
                );
              },
              child: Text('Retour à l\'accueil',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 87, 89, 90)),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
