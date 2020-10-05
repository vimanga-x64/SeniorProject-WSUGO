import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main(){
  runApp(WSUGo());
}

class WSUGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Setting my home route
      initialRoute: Login.id,
      //Setting all routes
      routes: {
        Login.id: (context) => Login(),
      },
    );
  }
}

