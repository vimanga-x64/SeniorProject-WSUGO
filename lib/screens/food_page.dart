import 'package:flutter/semantics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../food_data.dart';
import './drawer.dart';

class FoodPage extends StatefulWidget {
  static const String id = 'food_page';
  @override
  _FoodPageState createState() => _FoodPageState();
}

/*
#######################################################

Main construction of page

#######################################################
*/

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: shockerBlack),
          title: Text(
            'Dining Options',
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
                icon: Icon(Icons.place),
                text: 'Food Truck Plaza',
              ),
              Tab(
                icon: Icon(Icons.fastfood),
                text: 'Other',
              ),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: [
            TwitterAPI(),
            OtherFood(),
          ],
        ),
      ),
    );
  }
}

/*
#######################################################

Construction of Food Truck Plaza tab

#######################################################
*/

class TwitterAPI extends StatefulWidget {
  @override
  _TwitterAPIState createState() => _TwitterAPIState();
}

class _TwitterAPIState extends State<TwitterAPI> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      WebView(
        initialUrl: 'https://jtseiler15.github.io/',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (finish) {
          setState(() {
            isLoading = false;
          });
        },
      ),
      isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(),
    ]);
  }
}

/*
#######################################################

Construction of Other tab

#######################################################
*/

class OtherFood extends StatefulWidget {
  @override
  _OtherFoodState createState() => _OtherFoodState();
}

class _OtherFoodState extends State<OtherFood> {
  var rscData = FoodData.rscData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Rhatigan Student Center',
            textAlign: TextAlign.left,
            style: GoogleFonts.josefinSans(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: shockerBlack,
            ),
          ),
        ),
        Divider(
          color: shockerBlack,
          height: 10,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: rscData.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          rscData[index]['location'],
                          textAlign: TextAlign.left,
                          style: GoogleFonts.josefinSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: shockerBlack,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tSunday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Sun'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tMonday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Mon'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tTuesday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Tue'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tWednesday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Wed'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tThursday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Thu'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tFriday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Fri'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '\t\t\t\tSaturday:',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Text(
                                rscData[index]['Sat'],
                                textAlign: TextAlign.left,
                                style: GoogleFonts.josefinSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: shockerBlack,
                                ),
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: SizedBox(width: 30),
                              flex: 3,
                            ),
                          ],
                        ),
                        Divider(
                          color: shockerYellow,
                          height: 10,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
