import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wsu_go/screens/register_page.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/food_page.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  //Initializing FireBase before using it
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(WSUGo());
}

class WSUGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //Setting my home route
      initialRoute: Login.id,

      //Setting all routes so we can use the method "Navigator.pushNamed(context, routeName);"
      routes: {
        Login.id: (context) => Login(),
        HomePage.id: (context) => HomePage(),
        FoodPage.id: (context) => FoodPage(),
        Register.id: (context) => Register(),
      },
    );
  }
}
