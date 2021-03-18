import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class WeatherData {
  final DateTime date;
  final String name;
  final  temp;
  final String main;
  final String icon;
  final  high;
  final  low;
  final humidity;
  final windspeed;
  final visibilty;
  //DateTime sunrise;
  //DateTime sunset;

  WeatherData({this.date, this.name, this.temp, this.main, this.icon, this.high, this.low,
  this.humidity, this.visibilty, this.windspeed});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return  WeatherData(
      //date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].round(),
      main: json['weather'][0]['main'],
      high: json['main']['temp_max'].round(),
      low: json['main']['temp_min'].round(),
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
      visibilty: json['visibility']
      //icon: json['weather'][0]['icon'],
    );

  }

}

