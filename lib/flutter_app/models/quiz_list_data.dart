// Define the QuizListData class with its properties
class QuizListData {
  QuizListData({
    this.imagePath = '',
    this.QuestTarget = '',
    this.titleTxt = '',
    this.subTxt = '',
    this.startColor = '',
    this.endColor = '',
  });
  final String QuestTarget;
  final String imagePath;
  final String titleTxt;
  final String subTxt; // Subtitle text for the number of brands
  final String startColor;
  final String endColor;

  // A static list of quizzes to display
  static List<QuizListData> tabIconsList = <QuizListData>[
    QuizListData(
      imagePath:
          'assets/fitness_app/a.png', // Replace with your actual image path
      titleTxt: 'cybersécurité',
      QuestTarget: 'questionnaire4.json',
      subTxt: '18 Brands',
      startColor:
          '#FA7D82', // Colors are just placeholders, replace with your UI theme colors
      endColor: '#FFB295',
    ),
    QuizListData(
      imagePath:
          'assets/fitness_app/e.png', // Replace with your actual image path
      titleTxt: 'parascolaires',
      QuestTarget: 'questionnaire5.json',
      subTxt: '24 Brands',
      startColor:
          '#738AE6', // Colors are just placeholders, replace with your UI theme colors
      endColor: '#5C5EDD',
    ),
    QuizListData(
      imagePath:
          'assets/fitness_app/c.png', // Replace with your actual image path
      titleTxt: 'Associatif Enseirb',
      QuestTarget: 'questionnaire1.json',
      subTxt: '30 Brands',
      startColor:
          '#FE95B6', // Colors are just placeholders, replace with your UI theme colors
      endColor: '#FF5287',
    ), 
    QuizListData(
      imagePath:
          'assets/fitness_app/c.png', // Replace with your actual image path
      titleTxt: 'Life',
      QuestTarget: 'questionnaire2.json',
      subTxt: '30 Brands',
      startColor:
          '#FE95B6', // Colors are just placeholders, replace with your UI theme colors
      endColor: '#FF5287',
    ),
    QuizListData(
      imagePath:
          'assets/fitness_app/c.png', // Replace with your actual image path
      titleTxt: 'Étudiant',
      QuestTarget: 'questionnaire3.json',
      subTxt: '30 Brands',
      startColor:
          '#FE95B6', // Colors are just placeholders, replace with your UI theme colors
      endColor: '#FF5287',
    ),
    // Add more quizzes as needed
  ];
}
