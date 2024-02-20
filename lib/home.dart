import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Assurez-vous d'importer FirebaseAuth
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_gform/widgets/FormVisualize.dart';

class HomeScreen extends StatelessWidget {
  final String userId; // Ajouter cette ligne pour recevoir l'userId

  const HomeScreen(
      {super.key,
      required this.userId}); // Modifier le constructeur pour inclure userId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('logo_beeform.png'),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SignOutButton(),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers FormVisualize lorsque le bouton est appuyé
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormVisualizeApp(
                          userId: userId)), // Passer userId ici
                );
              },
              child: const Text('Commencer le questionnaire'),
            ),
          ],
        ),
      ),
    );
  }
}
