import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: shockerWhite,
        drawer: Drawer(child: LeftDrawer()),
        body: SafeArea(
          //AnimatedList goes here instead
          child: Greeting('Username'),
          top: true,
          bottom: true,
          left: true,
          right: true,
        ),
      ),
    );
  }
}

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Greeting extends StatefulWidget {
  final String name;
  Greeting(this.name);

  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {

  //Setting up Greeting Widget to retrieve data from FireBase
  //Start
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = _auth.currentUser;
      if(user != null) {
        loggedInUser = user;
        //Prints current users email in the log
        print(loggedInUser.email);
        //Signing the user out right away after printing their name in the log
        //_auth.signOut();
      }
    } catch (e){
      print(e);
    }
  }
  //End of FireBase*/

  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: FractionalOffset(0.08, 0.24),
        child: Text(
          'Hello, ${widget.name}',
          style: GoogleFonts.josefinSans(
            fontSize: 52,
            fontWeight: FontWeight.w800,
            color: shockerBlack,
          ),
        ),
      ),
    );
  }
}
