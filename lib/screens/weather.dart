import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main () => runApp(
    MaterialApp(
      title: "WEATHER",
      //home: Page1(),
    )
);
/*class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align (
          alignment: Alignment.topRight,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                  MaterialPageRoute(
                      builder: (context) => Home()

                  )
              );
            },
            child: Icon (
                Icons.wb_sunny,
                color: Colors.yellow,
                size: 65.0
            ),
          )),
    );

  }
}*/
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var feelsLike;
  var visibility;
  var high;
  var low;
  var sunrise;
  var sunset;
  var format_sunrise;
  var format_sunset;


  Future getWeather () async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Wichita&units=imperial&appid=b019ccfb8dc5321a73fdd9c6396105d8");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'].round();
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'].round();
      this.feelsLike = results['main']['feels_like'].round();
      this.visibility = results['visibility'];
      this.high = results['main']['temp_max'].round();
      this.low = results['main']['temp_min'].round();
      this.sunrise = results['sys']['sunrise'];
      format_sunrise = DateTime.fromMillisecondsSinceEpoch(sunrise*1000);
      this.sunset = results['sys']['sunset'];
      format_sunset = DateTime.fromMillisecondsSinceEpoch(sunset*1000);
    });
    //dynamic jsonObject = jsonDecode(jsonString);

    //dynamic sys = jsonObject['sys'];
    //print(sys);

    //sys['sunrise'] = getClockInUtcPlus3Hours(sys['sunrise'] as int);
    //sys['sunset'] = getClockInUtcPlus3Hours(sys['sunset'] as int);

    //print(sys);



    //String getClockInUtcPlus3Hours(int timeSinceEpochInSec)
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/white.jpg"),
                    fit : BoxFit.cover,
                    alignment: Alignment.center,
                    // colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child:Text(
                      "Currently in Wichita, KS",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

                  Text(
                    temp != null ? temp.toString() + " °F" : "Loading",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 75.0,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child:Text(
                      description != null ? description.toString() : "Loading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),

                  ),
                ],
              ),

          ),
          Container (
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20.0),
            color: Colors.yellow,
            child: Text ('Sunrise:        ${format_sunrise != null ? format_sunrise : "Loading"}'),


          ),
          Container (
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20.0),
            color: Colors.amberAccent,
            child : Text ('Sunset:        ${format_sunset != null ? format_sunset : "Loading"} '),
          ),
          Expanded (
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Feels Like"),
                    trailing: Text(feelsLike != null ? feelsLike.toString() + " °F" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.eye),
                    title: Text("Visibility"),
                    trailing: Text(visibility != null ? visibility.toString() + " m" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.water),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() + " %" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() + " mph" : "Loading"),
                  ),
                  ListTile (
                    leading: FaIcon(FontAwesomeIcons.arrowUp),
                    title: Text("Highest Temp"),
                    trailing: Text(high != null ? high.toString() + " °F" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.arrowDown),
                    title: Text("Lowest Temp"),
                    trailing: Text(low != null ? low.toString() + " °F" : "Loading"),
                  )
                  ],
              ),
            ),
          )
        ],
      ),
    );

  }
}