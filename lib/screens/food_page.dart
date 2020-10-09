import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';

class FoodPage extends StatefulWidget {
  static const String name = 'food_page';
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Grub',
              style: GoogleFonts.josefinSans(
                fontWeight: FontWeight.w800,
                color: shockerBlack,
              ),
            ),
            backgroundColor: shockerYellow,
            bottom: TabBar(
              indicatorColor: shockerBlack,
              labelColor: shockerBlack,
              tabs: [
                Tab(
                  icon: Icon(Icons.deck_rounded),
                  text: 'Food Truck Plaza',
                ),
                Tab(
                  icon: Icon(Icons.fastfood_rounded),
                  text: 'Other Dining Options',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TwitterAPI(),
              StaticFood(),
            ],
          ),
        ),
      ),
    );
  }
}

class TwitterAPI extends StatefulWidget {
  @override
  _TwitterAPIState createState() => _TwitterAPIState();
}

class _TwitterAPIState extends State<TwitterAPI> {
  final String twitterURL = "Twitter API goes here";

  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$twitterURL',
        style: GoogleFonts.josefinSans(
          fontSize: 52,
          fontWeight: FontWeight.w800,
          color: shockerBlack,
        ),
      ),
    );
  }
}

class StaticFood extends StatefulWidget {
  @override
  _StaticFoodState createState() => _StaticFoodState();
}

class _StaticFoodState extends State<StaticFood> {
  final String toDo = "Place dining info here";

  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$toDo',
        style: GoogleFonts.josefinSans(
          fontSize: 52,
          fontWeight: FontWeight.w800,
          color: shockerBlack,
        ),
      ),
    );
  }
}
