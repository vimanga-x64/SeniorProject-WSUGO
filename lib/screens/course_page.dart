import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import './add_course.dart';
import '../constants.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
// Import Cloud Firestore package
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursePage extends StatefulWidget {
  static const String id = 'course_page';
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: shockerBlack),
        title: Text(
          'Courses',
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.w800,
            color: shockerBlack,
          ),
        ),
        backgroundColor: shockerYellow,
      ),
      drawer: CustomDrawer(),
      floatingActionButton: AddButton(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StudentClasses(),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AddCourse.id);
      },
      child: Icon(Icons.add),
      backgroundColor: shockerYellow,
    );
  }
}


//Importing the CourseData class that Jordan created to store the retrieve data to be outputted
class CourseData {
  String courseInitials = '';
  String courseNums = '';
  String building = '';
  String roomNum = '';
  TimeOfDay startTime;
  TimeOfDay endTime;
  List<bool> weekDays = List.generate(7, (_) => false);
}

class StudentClasses extends StatefulWidget {
  @override
  _StudentClassesState createState() => _StudentClassesState();
}

class _StudentClassesState extends State<StudentClasses> {

  //List of CourseDataTest Objects that are waiting to be added when going through "Courses" Collection in Firestore
  List<CourseDataTest> courseObjects = [];

  //Creating a Stream function that is oging to return a variable type of "QuerySnapshot"
  Stream<QuerySnapshot> getUserCourseData() {
    //Creating two final variables to access FirebaseAuthentication and Cloud Firestore

    //Targets that current user that is logged in
    final _auth = FirebaseAuth.instance.currentUser;

    //Get the current logged in user's courses
    //They are targeted by their "_auth.uid"
    final studentCourses = FirebaseFirestore.instance.collection('Students').doc(_auth.uid).collection('Courses').snapshots();

    return studentCourses;
  }


  @override
  Widget build(BuildContext context) {

    //Returning a StreamBuilder widget to have app change data when Database is changed, "A constant Stream"
    return StreamBuilder<QuerySnapshot>(
      //Passing our stream into stream property
      stream: getUserCourseData(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        //If error occurs
        if(snapshot.hasError){
          return Center(
            child: CircularProgressIndicator(),
          );
        }


        //If connection is done
        if(snapshot.hasData) {
          //Final variable to hold List<QueryDocumentSnapshot>
          final courses = snapshot.data.docs;

          //Cycling through each Document (Courses)
          for(var course in courses){
            //Creating CourseDataTest objects and pass it to courseObjects variable
            courseObjects.add(CourseDataTest(
              courseInitials: course.data()["courseInitials"],
              courseNums: course.data()["courseNums"],
              building: course.data()["building"],
              roomNum: course.data()["roomNum"],
              weekDays: course.data()["weekdays"]
            ));
          }
        }

        return Column(
          children: [

          ],
        );
      },
    );
  }
}
