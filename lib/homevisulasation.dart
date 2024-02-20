// Dans le fichier custom_app.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gform/home_screen.dart';
import 'package:flutter_gform/main.dart';
import 'dart:io';
import 'package:flutter_gform/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_gform/widgets/FormVisualize.dart';

class CustomApp extends StatelessWidget {
  final String userId; // Ajouter cette ligne pour recevoir l'userId

  // Modifier le constructeur pour inclure userId
  const CustomApp({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Custom Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color.fromARGB(255, 36, 71, 37)),
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: MyHomePage(userId: userId), // Passer userId à MyHomePage
    );
  }
}
