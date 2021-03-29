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
  //Creating an instance for Firesore, students
  //Tapping into our collection of Students
  CollectionReference students =
      FirebaseFirestore.instance.collection('Students');

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

class _StudentClassesState extends State<StudentClasses> {
  //Creating a Future function that is going to return a variable type of "QuerySnapshot"
  //Future function is async with an awaiting variable of student that is type "QuerySnapshot"
  Future<QuerySnapshot> getUserCourseData() async {
    //Creating two final variables to access FirebaseAuthentication and Cloud Firestore

    //Targets that current user that is logged in
    final _auth = FirebaseAuth.instance.currentUser;

    //Get the current logged in student's data
    //They are targeted by their "_auth.uid"
    final student = FirebaseFirestore.instance
        .collection('Students')
        .doc(_auth.uid)
        .collection('Course')
        .get();

    return await student;
  }

  @override
  Widget build(BuildContext context) {
    //Returning FutureBuilder() widget that is going to assist on waiting for
    return FutureBuilder(
      //Set future variable as our Future<QuerySnapshot>
      future: getUserCourseData(),
      builder: (),
    );
  }
}
