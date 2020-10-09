import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_page.dart';
import 'screens/food_page.dart';

void main() {
  runApp(WSUGo());
}

class WSUGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Setting my home route

      //initialRoute: FoodPage.name,
      //initialRoute: Login.id,
      initialRoute: HomePage.name,

      //Setting all routes
      routes: {
        //Login.id: (context) => Login(),
        HomePage.name: (context) => HomePage(),
        //FoodPage.name: (context) => FoodPage(),
      },
    );
  }
}
