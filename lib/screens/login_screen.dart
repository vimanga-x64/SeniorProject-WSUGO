import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  //Providing an id for routes to target
  static const String id = 'login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //Decoration property to include the background image of the screen
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loginbackground'),
              fit: BoxFit.cover,
            ),
          ),
          //Start of main widgets
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Sized boxes are place throughout to add invisible space in between other widgets
              SizedBox(
                height: 20,
              ),
              //Heading
              Text(
                'WSU GO!',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w900),
                  //color: shockerYellow,
                ),
              ),
              //WU LOGO
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Image.asset('images/wsulogo.png'),
              ),
              SizedBox(
                height: 10,
              ),
              //Container to allow padding for TextField
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'UserName',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Container to allow padding for TextField
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //ButtonBar acts like a custom ROW widget for different type of buttons
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () => {},
                    color: shockerYellow,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 75,
                  ),
                  RaisedButton(
                    onPressed: () => {},
                    color: shockerYellow,
                    child: Text(
                        'Login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
