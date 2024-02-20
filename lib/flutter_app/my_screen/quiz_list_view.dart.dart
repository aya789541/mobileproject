import 'package:flutter/material.dart';
import 'package:flutter_gform/flutter_app/models/quiz_list_data.dart';
import 'package:flutter_gform/widgets/FormVisualize.dart';
import '../../SharedData.dart';
class QuizListView extends StatefulWidget {
  final String userId;
  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  
  const QuizListView({
    Key? key,
    required this.userId,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  @override
  _QuizListViewState createState() => _QuizListViewState();
}

class _QuizListViewState extends State<QuizListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<QuizListData> quizListData = QuizListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: quizListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      quizListData.length > 10 ? 10 : quizListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return QuizView(
                    quizData: quizListData[index],
                    animation: animation,
                    animationController: animationController!,
                    userId: widget.userId, // Pass userId to QuizView
                    onTap: () { 
                      SharedData.quest=quizListData[index].QuestTarget; 
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FormVisualizeApp(userId: widget.userId),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

class QuizView extends StatelessWidget {
  const QuizView({
    Key? key,
    this.quizData,
    this.animationController,
    this.animation,
    this.userId, // Accept userId
    this.onTap,
  }) : super(key: key);

  final QuizListData? quizData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String? userId; // Declare userId
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 130,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          quizData!.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quizData!.titleTxt,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 12.0),
                        child: Text(
                          quizData!.subTxt,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
