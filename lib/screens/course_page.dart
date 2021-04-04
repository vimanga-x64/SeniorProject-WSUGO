import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import './add_course.dart';
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

class StudentClasses extends StatefulWidget {
  @override
  _StudentClassesState createState() => _StudentClassesState();
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

class _StudentClassesState extends State<StudentClasses> {

  //List of Course Objects that are waiting to be added when going through Courses Collection in Firestore
  List<CourseData> courseObjects = [];

  @override
  Widget build(BuildContext context) {
    //Getting our current user's information
    final firebaseUser = FirebaseAuth.instance.currentUser;

    //Creating a stream variable that holds <QuerySnapshots> of 'Courses' collection
    Stream collectionStream = FirebaseFirestore.instance.collection('Students').doc(firebaseUser.uid).collection('Courses').snapshots();

    //Returning StreamBuilder() widget that is going to assist on waiting for
    return StreamBuilder<QuerySnapshot>(
      stream: collectionStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.hasData){
          //Final variable to hold a List<QueryDocumentSnapshots> of courses
          final courses = snapshot.data.docs;

          //Looping through each document in Courses collection to store each course data in CourseData object
          //That CourseData object will be store in a list of courseObjects
          for (var course in courses) {
            courseObjects.add(CourseData(

            ));
          }
          //there are multiple 'course' currently in 'courses' that needs to be displayed
        }

        return Column(
          children: [
            Text('test2'),
          ],
        );
      },
    );
  }
}
