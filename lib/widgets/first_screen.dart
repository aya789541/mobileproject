import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gform/auth_gate.dart';
import 'package:flutter_gform/flutter_app/app_home_screen.dart';

// Dummy pages for Privacy and Home, replace with actual pages
class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Page'),
      ),
      body: Center(
        child: Text('This is the Privacy Page'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userId;

  HomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('This is the Home Page for user $userId'),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Page'),
      ),
      body: Center(
        child: Text('This is the Sign In Page'),
      ),
    );
  }
}

class SimpleLogin extends StatefulWidget {
  final String userId;

  SimpleLogin({required this.userId});

  @override
  _SimpleLoginState createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Use the selected image
  }

  void _navigateToPrivacy() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PrivacyPage()));
  }

  void _navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FitnessAppHomeScreen(userId: widget.userId)));
  }

  void _navigateToSignIn() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AuthGate()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(70, 130, 180, 1), // Bleu moyen
                      Color.fromRGBO(135, 206, 235, 1), // Bleu ciel
                    ],
                  )),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 47,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: Icon(Icons.person, color: Colors.grey[800]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey[800],
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: Text(
                  "Welcome Again",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          ActionButton(
            title: "Privacy",
            icon: Icons.privacy_tip,
            onTap: _navigateToPrivacy,
          ),
          SizedBox(height: 20),
          ActionButton(
            title: "Home",
            icon: Icons.home,
            onTap: _navigateToHome,
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(70, 130, 180, 1), // Bleu moyen
                      Color.fromRGBO(135, 206, 235, 1), // Bleu ciel
                    ],
                  )),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                onPressed: _navigateToSignIn,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Sign Out"),
                    SizedBox(width: 8),
                    Icon(Icons.logout),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Colors.grey[800]),
                SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.49, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
