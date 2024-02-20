import 'package:flutter_gform/flutter_app/app_home_screen.dart';

import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
    required this.userId,
  });

  Widget? navigateScreen;
  String imagePath;
  String userId;

  static List<HomeList> getHomeList(String userId) {
    return [
      HomeList(
        imagePath: 'assets/fitness_app/logo_beeform.png',
        navigateScreen: FitnessAppHomeScreen(userId: userId),
        userId: userId,
      ),
    ];
  }
}
