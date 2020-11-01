import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import './drawer.dart';
import './weather.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shockerWhite,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: shockerBlack),
        actions: <Widget> [
          IconButton(
            icon : const Icon(Icons.wb_sunny),
            color: shockerYellow,
            tooltip: 'Weather',
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => WeatherApp()
                )
              );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: shockerWhite,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Greeting('User'),
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text("Today at a glance:",
                    style: GoogleFonts.josefinSans(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: shockerBlack,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              CourseTile(),
              SizedBox(
                height: 10,
              ),
              CourseTile(),
            ],
          ),
        ),
      ),


    );
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
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //Prints current users email in the log
        print(loggedInUser.email);
        //Signing the user out right away after printing their name in the log
        //_auth.signOut();
      }
    } catch (e) {
      print(e);
    }
  }
  //End of FireBase*/

  Widget build(BuildContext context) {
    return Text(
      'Hello,\n${widget.name}',
      style: GoogleFonts.josefinSans(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: shockerBlack,
      ),
    );
  }
}

/*class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align (
          alignment: Alignment.topRight,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                  MaterialPageRoute(
                      builder: (context) => WeatherApp()

                  )
              );
            },
            child: Icon (
                Icons.wb_sunny,
                color: shockerYellow,
                size: 65.0
            ),
          )),
    );

  }
}*/

class CourseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: shockerYellowOpaque, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: <Widget>[
          Icon(Icons.book),
          SizedBox(
            width: 17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Senior Design",
                style: GoogleFonts.josefinSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: shockerBlack,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "EE 585",
                style: GoogleFonts.josefinSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: shockerBlack,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "9:30 AM - 11:45 AM",
                style: GoogleFonts.josefinSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: shockerBlack,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "John Bardo Center 338",
                style: GoogleFonts.josefinSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: shockerBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
