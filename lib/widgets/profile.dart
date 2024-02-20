import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gform/auth_gate.dart';
import 'package:flutter_gform/flutter_app/app_home_screen.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String avatarUrl = 'assets/avatar1.png';
  Color headerColor = Colors.pink[100]!;
  Color iconColor = Colors.pink[300]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatarUrl),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Welcome Again', style: TextStyle(fontSize: 18)),
                  Text('Choose your  Avatar',
                      style: TextStyle(color: Colors.grey[700])),
                  IconButton(
                    icon: Icon(Icons.edit, color: iconColor),
                    onPressed: _showAvatarPicker,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                _buildListTile('Privacy', Icons.security,
                    () => _navigateToPrivacy(context)),
                _buildListTile(
                    'Home Page', Icons.home, () => _navigateToHome(context)),
                _buildListTile('Logout', Icons.exit_to_app, _signOut),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon, color: iconColor),
      onTap: onTap,
    );
  }

  void _navigateToPrivacy(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PrivacyPage()));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FitnessAppHomeScreen(userId: widget.userId)));
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AuthGate()));
  }

  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Choose an Avatar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _avatarOption(dialogContext, 'assets/avatar1.png',
                    changeTheme: false),
                _avatarOption(dialogContext, 'assets/avatar2.png',
                    changeTheme: true),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector _avatarOption(BuildContext dialogContext, String assetPath,
      {required bool changeTheme}) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundImage: AssetImage(assetPath),
      ),
      onTap: () {
        setState(() {
          avatarUrl = assetPath;
          if (changeTheme) {
            headerColor = Colors.lightBlue.shade200;
            iconColor = Colors.blue;
          } else {
            headerColor = Colors.pink[100]!;
            iconColor = Colors.pink[300]!;
          }
        });
        Navigator.of(dialogContext).pop();
      },
    );
  }
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: Center(
        child: Text('Privacy Page Content'),
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Text('Sign In Page Content'),
      ),
    );
  }
}
