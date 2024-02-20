import 'package:flutter/material.dart';
import 'package:flutter_gform/app_theme.dart';
import '/homelist.dart';

class MyHomePage extends StatefulWidget {
  final String userId;

  const MyHomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<HomeList> homeList;
  double opacity = 0.0; // Initial opacity set to 0 for animation

  @override
  void initState() {
    homeList = HomeList.getHomeList(widget.userId);
    super.initState();
    // Start the animation after a slight delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0; // Change opacity to 1 to fade in the image
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: homeList.isNotEmpty
          ? GestureDetector(
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        homeList[0].navigateScreen!,
                  ),
                );
              },
              child: Center(
                child: AnimatedOpacity(
                  opacity: opacity, // Bind the opacity to the state variable
                  duration:
                      Duration(seconds: 1), // Duration of the fade animation
                  child: Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
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
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        homeList[0].imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const Center(child: Text('No image to display')),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 4,
      title: const Text('Flutter UI'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.dashboard),
          onPressed: () {
            // Implement your icon button action here
          },
        ),
      ],
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({
    Key? key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              50 * (1.0 - animation!.value),
              0.0,
            ),
            child: InkWell(
              onTap: callBack,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(listData!.imagePath),
                    fit: BoxFit.cover,
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
