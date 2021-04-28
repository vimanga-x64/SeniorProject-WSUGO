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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
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
      child: Icon(Icons.add, color: shockerYellow),
      backgroundColor: Colors.black,
    );
  }
}

class StudentClasses extends StatefulWidget {
  @override
  _StudentClassesState createState() => _StudentClassesState();
}

class _StudentClassesState extends State<StudentClasses> {
  //List of CourseDataRead Objects that are waiting to be added when going through "Courses" Collection in Firestore
  List<CourseDataRead> courseObjects = [];

  //Creating a Stream function that is oging to return a variable type of "QuerySnapshot"
  Stream<QuerySnapshot> getUserCourseData() {
    //Creating two final variables to access FirebaseAuthentication and Cloud Firestore

    //Targets that current user that is logged in
    final _auth = FirebaseAuth.instance.currentUser;

    //Get the current logged in user's courses
    //They are targeted by their "_auth.uid"
    final studentCourses = FirebaseFirestore.instance
        .collection('Students')
        .doc(_auth.uid)
        .collection('Courses')
        .snapshots();

    return studentCourses;
  }

  void deleteUserCourseData(String docID) {
    final _auth = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('Students')
        .doc(_auth.uid)
        .collection('Courses')
        .doc(docID)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    //Returning a StreamBuilder widget to have app change data when Database is changed, "A constant Stream"
    return StreamBuilder<QuerySnapshot>(
      //Passing our stream into stream property
      stream: getUserCourseData(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //If error occurs
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        //If connection is done
        if (snapshot.hasData) {
          //Final variable to hold List<QueryDocumentSnapshot>
          final courses = snapshot.data.docs;

          //Erase all list items and input new snapshot items
          courseObjects.clear();

          //Cycling through each Document (Courses)
          for (var course in courses) {
            //Creating CourseDataTest objects and pass it to courseObjects variable
            courseObjects.add(CourseDataRead(
                docID: course.id,
                courseInitials: course.data()["courseInitials"],
                courseNums: course.data()["courseNums"],
                building: course.data()["building"],
                roomNum: course.data()["roomNum"],
                startTime: course.data()["startTime"],
                endTime: course.data()["endTime"],
                weekDays: course.data()["weekdays"]));
          }
        }

        //Outputting our database values!
        return Expanded(
            child: courseObjects.isEmpty
                ? Center(
                child: Text(
                  'No Classes stored.',
                  style: GoogleFonts.josefinSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: shockerBlack,
                  ),
                ))
                : ListView.separated(
              itemCount: courseObjects.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      setState(() {
                        deleteUserCourseData(courseObjects[index].docID);
                        courseObjects.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: shockerYellowOpaque,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
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
                                courseObjects[index].courseInitials +
                                    " " +
                                    courseObjects[index].courseNums,
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
                                "At: " +
                                    courseObjects[index].startTime +
                                    " - " +
                                    courseObjects[index].endTime,
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
                                "In: " +
                                    courseObjects[index].building +
                                    " " +
                                    courseObjects[index].roomNum,
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
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(
                height: 10,
              ),
            ));
      },
    );
  }
}
