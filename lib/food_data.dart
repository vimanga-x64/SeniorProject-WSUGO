import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Restaurant Class
class Restaurant {
  //Properties of location and Days
  final String location;
  final String sat;
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sun;

  //Constructor of Restaurant
  Restaurant(
      {this.location,
      this.sat,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sun});

  //Factory to create Restaurant Objects
  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    //Assigning the document's data to Map variable of data
    Map data = doc.data();

    //Using the Constructor to create an object, passing the Map data's values
    return Restaurant(
        location: data["location"],
        sat: data["sat"],
        mon: data["mon"],
        tue: data["tue"],
        wed: data["wed"],
        thu: data["thu"],
        fri: data["fri"],
        sun: data["sun"]);
  }
}

class FoodData {
  static final rscData = [
    {
      'location': "Chick-fil-A",
      'Sun': 'Closed',
      'Mon': '7:00a - 7:00p',
      'Tue': '7:00a - 7:00p',
      'Wed': '7:00a - 7:00p',
      'Thu': '7:00a - 7:00p',
      'Fri': '7:00a - 5:00p',
      'Sat': '11:00a - 2:00p',
    },
    {
      'location': "Freddy's",
      'Sun': 'Closed',
      'Mon': '10:00a - 2:00p',
      'Tue': '10:00a - 2:00p',
      'Wed': '10:00a - 2:00p',
      'Thu': '10:00a - 2:00p',
      'Fri': '10:00a - 2:00p',
      'Sat': 'Closed',
    },
    {
      'location': "Panda Express",
      'Sun': 'Closed',
      'Mon': '10:00a - 7:00p',
      'Tue': '10:00a - 7:00p',
      'Wed': '10:00a - 7:00p',
      'Thu': '10:00a - 7:00p',
      'Fri': '10:00a - 5:00p',
      'Sat': 'Closed',
    },
    {
      'location': "Pizza Hut",
      'Sun': 'Closed',
      'Mon': '10:00a - 2:00p',
      'Tue': '10:00a - 2:00p',
      'Wed': '10:00a - 2:00p',
      'Thu': '10:00a - 2:00p',
      'Fri': '10:00a - 2:00p',
      'Sat': 'Closed',
    },
    {
      'location': "Starbucks",
      'Sun': 'Closed',
      'Mon': '7:00a - 7:00p',
      'Tue': '7:00a - 7:00p',
      'Wed': '7:00a - 7:00p',
      'Thu': '7:00a - 7:00p',
      'Fri': '7:00a - 5:00p',
      'Sat': '9:00a - 2:00p',
    },
  ];
}
