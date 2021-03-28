import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import './course_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCourse extends StatefulWidget {
  static const String id = 'add_course';
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: shockerBlack),
          title: Text(
            'Add a Course',
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w800,
              color: shockerBlack,
            ),
          ),
          backgroundColor: shockerYellow,
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CoursePage()),
            );
          }),
        ),
        body: CourseForm());
  }
}

class CourseData {
  String courseInitials = '';
  String courseNums = '';
  String building = '';
  String roomNum = '';
  TimeOfDay startTime;
  TimeOfDay endTime;
  List<bool> weekDays = List.generate(7, (_) => false);
}

//Create instance of database object
CourseData course = CourseData();

class CourseForm extends StatefulWidget {
  @override
  CourseFormState createState() {
    return CourseFormState();
  }
}

class CourseFormState extends State<CourseForm> {
  //Key to validate the form
  final _formKey = GlobalKey<FormState>();

  //Create an instance of Cloud Firestore
  final firestoreInstance = FirebaseFirestore.instance;

  //Create an authorization of the current user
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),

            //1st Row of Input Boxes
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                //Course Initials Textbox
                Expanded(child: CourseInitialsField()),

                SizedBox(
                  width: 20,
                ),

                //Course Number Textbox
                Expanded(child: CourseNumsField()),

                SizedBox(
                  width: 20,
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            //2nd Row of Input Boxes
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                //Building Name Textbox
                Expanded(child: BuildingField()),

                SizedBox(
                  width: 20,
                ),

                //Room Number Textbox
                Expanded(child: RoomNumField()),

                SizedBox(
                  width: 20,
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            //3rd Row of Input Boxes
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),

                //Start Time Button
                Expanded(child: TimePicker()),

                SizedBox(
                  width: 20,
                ),

                //End Time Textbox
                Expanded(child: TimePicker()),

                SizedBox(
                  width: 20,
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            //Weekday Toggle buttons
            ToggleButtons(
              children: <Widget>[
                Text('Su'),
                Text('M'),
                Text('T'),
                Text('W'),
                Text('Th'),
                Text('F'),
                Text('Sa'),
              ],
              isSelected: course.weekDays,
              onPressed: (int index) {
                setState(() {
                  course.weekDays[index] = !course.weekDays[index];
                });
              },
              color: shockerBlack,
              selectedColor: shockerBlack,
              fillColor: shockerYellow,
            ),
            SizedBox(
              height: 30,
            ),

            //Submit Class Button
            OutlinedButton.icon(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  firestoreInstance
                      .collection('Students')
                      .doc(firebaseUser.uid)
                      .collection('Courses')
                      .add({
                    'courseInitials': course.courseInitials,
                    'courseNums': course.courseNums,
                    'building': course.building,
                    'roomNum': course.roomNum,
                    'startTime': course.startTime,
                    'weekdays': [
                      course.weekDays[0],
                      course.weekDays[1],
                      course.weekDays[2],
                      course.weekDays[3],
                      course.weekDays[4],
                      course.weekDays[5],
                      course.weekDays[6]
                    ]
                  });
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Course Added')));
                }
              },
              icon: Icon(Icons.add, color: shockerYellow),
              label: Text('Add Course', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}

class CourseInitialsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shockerYellow,
              width: 1,
            ),
          ),
          labelText: 'Course Initials',
          labelStyle: TextStyle(color: Colors.black),
          hintText: 'EE'),
      onChanged: (value) {
        course.courseInitials = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter Course Initials' : null;
      },
    );
  }
}

class CourseNumsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shockerYellow,
              width: 1,
            ),
          ),
          labelText: 'Course Number',
          labelStyle: TextStyle(color: Colors.black),
          hintText: '595'),
      onChanged: (value) {
        course.courseNums = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter a Course Number' : null;
      },
    );
  }
}

class BuildingField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shockerYellow,
              width: 1,
            ),
          ),
          labelText: 'Building Name',
          labelStyle: TextStyle(color: Colors.black),
          hintText: 'Jabara'),
      onChanged: (value) {
        course.building = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter a Building Name' : null;
      },
    );
  }
}

class RoomNumField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shockerYellow,
              width: 1,
            ),
          ),
          labelText: 'Room Number',
          labelStyle: TextStyle(color: Colors.black),
          hintText: '128'),
      onChanged: (value) {
        course.roomNum = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter a Room Number' : null;
      },
    );
  }
}

/*
class StartTimeField extends State<StartTimeField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Time: ${course.startTime.hour}:${course.startTime.minute}"),
      trailing: Icon(Icons.keyboard_arrow_down),
      onTap: _pickTime,
    );
  }

  _pickTime() async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: course.startTime);

    if (t != null)
      setState(() {
        course.startTime = t;
      });
  }
}
*/

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time = TimeOfDay(hour: 8, minute: 00);

  void _selectTime(newTime) async {
    newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _selectTime(course.startTime),
          child: Text('SELECT START TIME'),
        ),
        SizedBox(height: 5),
        Text(
          'Selected time: ${_time.format(context)}',
        ),
      ],
    );
  }
}
