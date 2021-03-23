import 'package:cloud_firestore/cloud_firestore.dart';

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
