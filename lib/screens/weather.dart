import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:wsu_go/constants.dart';
import 'package:wsu_go/ForecastData.dart';
import 'package:wsu_go/WeatherData.dart';
import 'package:wsu_go/WeatherItem.dart';
import 'package:wsu_go/CardItem.dart';
import './drawer.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  //Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Weather',
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w800,
              color: shockerBlack
            ),),
                backgroundColor: shockerYellow ),
          drawer: CustomDrawer(),
          body: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: weatherData != null ? Weather(weather: weatherData) : Container(),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150.0,
                          child: forecastData != null ? ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                          ) : Container(),
                        ),
                      ),
                    ),
                    //SizedBox(height: 150),
                    Expanded (
                      child: Padding(

                        padding: EdgeInsets.all(20.0),
                        child: ListView(
                          children: <Widget>[
                            Text('Additional Info', style: TextStyle(color: Colors.black,
                              fontSize: 25, fontWeight: FontWeight.w900
                            ),),

                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.thermometerHalf) ,
                              title: Text("Feels Like", style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20
                              ),),
                              trailing: Text(weatherData.humidity.toString() + " °F"),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.eye),
                              title: Text("Visibility", style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20
                              ),),
                              trailing: Text(weatherData.visibilty.toString() + " mi"),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.water),
                              title: Text("Humidity", style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20
                              )),
                              trailing: Text(weatherData.humidity.toString() + "%"),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.wind),
                              title: Text("Wind Speed", style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20
                              ),),
                              trailing: Text(weatherData.windspeed.toString() + " mph"),
                            )


                          ],
                        ),
                      ),
                    )
                    ]
              )
          )
      ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });


    final lat = 37.6922;
    final lon = -97.3375;

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?&units=imperial&APPID=b019ccfb8dc5321a73fdd9c6396105d8&lat=${lat
              .toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?&units=imperial&APPID=b019ccfb8dc5321a73fdd9c6396105d8&lat=${lat
              .toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
          new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
          new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }


    setState(() {
      isLoading = false;
    });
  }
}