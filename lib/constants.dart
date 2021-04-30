import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const Color shockerYellow = const Color(0xFFFFCD00);
const Color shockerYellowOpaque = const Color(0xFFFFCD23);
const Color shockerWhite = const Color(0xFFFFFFFF);
const Color shockerBlack = const Color(0xFF000000);

//CourseData Class
class CourseDataRead {
  // Document ID stored in Firestore
  final String docID;

  //Properties of a course
  final String courseInitials;
  final String courseNums;
  final String building;
  final String roomNum;
  final String startTime;
  final String endTime;
  final List<dynamic> weekDays;

  //Constructor of a course
  CourseDataRead(
      {this.docID,
        this.courseInitials,
        this.courseNums,
        this.building,
        this.roomNum,
        this.startTime,
        this.endTime,
        this.weekDays});

  //Factory to create CourseData objects
  factory CourseDataRead.fromFirestore(DocumentSnapshot doc) {
    //Assigning the document's data to a Map variable "data"
    Map data = doc.data();

    //Using the Constructor to create an object, passing the Map "data" values
    return CourseDataRead(
        docID: doc.id,
        courseInitials: data["courseInitials"],
        courseNums: data["courseNums"],
        building: data["building"],
        roomNum: data["roomNum"],
        startTime: data["startTime"],
        endTime: data["endTime"],
        weekDays: data["weekdays"]);
  }
}
