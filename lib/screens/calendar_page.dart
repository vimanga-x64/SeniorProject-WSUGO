import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wsu_go/constants.dart';
import './drawer.dart';
//Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
//Import Cloud Firestore package
import 'package:cloud_firestore/cloud_firestore.dart';
import './register_page.dart';

class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  //Allows for selecting day
  CalendarController _controller;

  //Stores date with all the events as a list
  Map<DateTime, List<dynamic>> _events;

  //Allows for adding events
  TextEditingController _eventController;

  //Prints events on day select
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
  }

  //Creating an instance for firebase auth
  final _auth = FirebaseAuth.instance;

  //Tapping into our collection of Students
  CollectionReference students = FirebaseFirestore.instance.collection('Students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: shockerYellow,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                  todayColor: shockerYellow,
                  selectedColor: shockerBlack
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: shockerBlack,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                    color: shockerWhite
                ),
              ),
              //Prints events when a date is selected
              onDaySelected: (date, events, _) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
              title: Text(event),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay]
                      .add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [
                    _eventController.text];
                }
                //Sending data to firestore
                students.doc(_auth.currentUser.uid).set({
                  'Events': _eventController.text,
                  'Date': _controller.selectedDay
                });
                //Allows for 2 or more events on same date
                _eventController.clear();
                //Closes flat button after save is clicked
                Navigator.pop(context);
              },
            )
          ],
        ));
    //Updates the events without having to reselect day
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}
