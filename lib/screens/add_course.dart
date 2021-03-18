import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import './course_page.dart';

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
  String courseIntials = '';
  String classNums = '';
  String building = '';
  String roomNum = '';
  List<bool> weekDays = List.generate(7, (_) => false);
}

class CourseForm extends StatefulWidget {
  @override
  CourseFormState createState() {
    return CourseFormState();
  }
}

class CourseFormState extends State<CourseForm> {
  //Key to validate the form
  final _formKey = GlobalKey<FormState>();

  //Create instance of database object
  CourseData course = CourseData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: shockerYellow,
                        width: 1,
                      )),
                      labelText: 'Course Initials',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'EE'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Course Initials';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                width: 20,
              ),

              //Course Number Textbox
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: shockerYellow,
                        width: 1,
                      )),
                      labelText: 'Course Number',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: '595'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Course Number';
                    }
                    return null;
                  },
                ),
              ),
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
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: shockerYellow,
                        width: 1,
                      )),
                      labelText: 'Building Name',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Jabara'),
                ),
              ),

              SizedBox(
                width: 20,
              ),

              //Room Number Textbox
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: shockerYellow,
                        width: 1,
                      )),
                      labelText: 'Room Number',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: '128'),
                ),
              ),
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Course Added')));
              }
            },
            icon: Icon(Icons.add, color: shockerYellow),
            label: Text('Add Course', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
