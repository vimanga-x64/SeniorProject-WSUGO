import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import './campus_map_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildingData extends StatefulWidget {
  static const String id = 'building_data';
  @override
  _BuildingData createState() => _BuildingData();
}

class _BuildingData extends State<BuildingData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Building Key'),
          backgroundColor: shockerYellow,
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MapPage()),
            );
          }),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('buildingData').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.documents.map((document) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 12,
                      child: Text("Name: " + document['Name'] + " \nInitials: " + document['Initials']),
                    ),
                  );
                }).toList(),
              );
            }
        )
    );
  }
}