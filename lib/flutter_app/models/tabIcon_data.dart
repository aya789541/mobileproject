import 'package:flutter/material.dart';

class TabIconData {
  IconData iconData;
  IconData selectedIconData;
  bool isSelected;
  int index;
  AnimationController? animationController;

  TabIconData({
    required this.iconData,
    required this.selectedIconData,
    this.isSelected = false,
    this.index = 0,
    this.animationController,
  });

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: Icons.home, // Icône pour le premier onglet (non sélectionné)
      selectedIconData:
          Icons.home_filled, // Icône pour le premier onglet (sélectionné)
      index: 0,
      isSelected: true,
    ),
    TabIconData(
      iconData:
          Icons.dashboard, // Icône pour le deuxième onglet (non sélectionné)
      selectedIconData:
          Icons.dashboard, // Icône pour le deuxième onglet (sélectionné)
      index: 1,
      isSelected: false,
    ),
    TabIconData(
      iconData:
          Icons.search, // Icône pour le troisième onglet (non sélectionné)
      selectedIconData:
          Icons.search, // Icône pour le troisième onglet (sélectionné)
      index: 2,
      isSelected: false,
    ),
    TabIconData(
      iconData:
          Icons.person, // Icône pour le quatrième onglet (non sélectionné)
      selectedIconData:
          Icons.person, // Icône pour le quatrième onglet (sélectionné)
      index: 3,
      isSelected: false,
    ),
  ];
}
