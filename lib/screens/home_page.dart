import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
// Import Cloud Firestore package
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import './drawer.dart';
import './weather.dart';
import 'package:wsu_go/WeatherData.dart';
import 'package:wsu_go/WeatherItem.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData weather = new WeatherData();
  bool isLoading = false;
  //Creating an instance for Firestore, students
  //Tapping into our collection of Students
  CollectionReference students =
      FirebaseFirestore.instance.collection('Students');
  @override
  void initState() {
    super.initState();
    
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shockerWhite,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: shockerBlack),
        actions: <Widget>[
          IconButton(
              padding: new EdgeInsets.all(0),
              icon: Text ('${weather.temp.toString()}°F', style: new TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300)), onPressed: null),
          //Text('${weather.temp.toString()}°F', style: new TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w300)),
          IconButton(
            padding: new EdgeInsets.all(0),
            icon: const Icon(Icons.wb_sunny_sharp),
            color: shockerYellow,
            tooltip: 'Weather',
            iconSize: 20,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WeatherPage()));
            },
          ),
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
              Greeting(),
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
  loadWeather() async {
    setState(() {
      isLoading = true;
    });


    final lat = 37.6922;
    final lon = -97.3375;

    final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?&units=imperial&APPID=b019ccfb8dc5321a73fdd9c6396105d8&lat=${lat
            .toString()}&lon=${lon.toString()}');



    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weather =
        new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        isLoading = false;
      });
    }


    setState(() {
      isLoading = false;
    });
  }
}

class Greeting extends StatefulWidget {
  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  //Variables for greeting statement
  TimeOfDay now = TimeOfDay.now();
  int noon = 12;
  int fivePM = 17;

  //Setting up Greeting Widget to retrieve data from FireBase

  //Creating a Future function that is going to return a variable type of "DocumentSnapshot"
  //Future function is async with an awaiting variable of student that is type "DocumentSnapshot"
  Future<DocumentSnapshot> getUserFirstName() async {
    //Creating two final variables to access FirebaseAuthentication and Cloud Firestore

    //Targets that current user that is logged in
    final _auth = FirebaseAuth.instance.currentUser;

    //Get the current logged in student's data
    //They are targeted by their "_auth.uid"
    final student =
        FirebaseFirestore.instance.collection('Students').doc(_auth.uid).get();
    return await student;
  }

  Widget build(BuildContext context) {
    //Returning FutureBuilder() widget that is going to assist on waiting for
    return FutureBuilder(
      //Set future variable as our Future<DocumentSnapshot>
      future: getUserFirstName(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //If statement to check to see if snapshot is returning any data
        if(snapshot.hasData) {
          //Creating a Map variable with key being a String and Value being Dynamic
          //The data variable is set to the documents (Data like their first name and classes) inside the collection (Students)
          Map<String, dynamic> data = snapshot.data.data();
          //If-Else statement to handle if the connection is valid or not
          if (snapshot.connectionState == ConnectionState.done) {
            //If-Else statements to change the greeting per time-of-day
            if (now.hour < noon) {
              return Text(
                "Good morning,\n${data['First Name']}",
                style: GoogleFonts.josefinSans(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: shockerBlack,
                ),
              );
            } else if (now.hour >= noon && now.hour < fivePM) {
              return Text(
                "Good afternoon,\n${data['First Name']}",
                style: GoogleFonts.josefinSans(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: shockerBlack,
                ),
              );
            } else if (now.hour >= fivePM) {
              return Text(
                "Good evening,\n${data['First Name']}",
                style: GoogleFonts.josefinSans(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: shockerBlack,
                ),
              );
            } else {
              return Text(
                "Hello,\n${data['First Name']}",
                style: GoogleFonts.josefinSans(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: shockerBlack,
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text('Null');
          }
        } else{
          return Text('Null');
        }
        return Text('Null');
        },
    );
  }
}

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
