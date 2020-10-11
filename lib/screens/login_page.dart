import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/screens/register_page.dart';

class Login extends StatefulWidget {
  //Providing an id for routes to target
  static const String id = 'login_page';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //Decoration property to set our static background image
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/loginbackground'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            //Start of main widgets
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Sized boxes are place throughout to add invisible space in between other widgets
                SizedBox(
                  height: 25,
                ),
                //Heading Title
                Text(
                  'WSUGo!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900),
                    ),
                ),
                //WU LOGO
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Image.asset('images/wsulogo.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                //Container to allow padding for TextField
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    //Decoration property to customize box appearance regarding color and when users click on it
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.5
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1
                          )
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )
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
                    style: TextStyle(color: Colors.white),
                    //Decoration property to customize box appearance regarding color and when users click on it
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1
                          )
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      )
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
                    //ButtonTheme widget to allow customization with buttons
                    ButtonTheme(
                      minWidth: 70,
                      height: 45,
                      child: RaisedButton (
                        //Redirects to Register page
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return Register();
                                },
                              ),
                          );
                        },
                        color: shockerYellow,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75,
                    ),
                    ButtonTheme(
                      minWidth: 86,
                      height: 45,
                      child: RaisedButton (
                        //Redirects to Home page
                        onPressed: () => {},
                        color: shockerYellow,
                        child: Text(
                            'Login',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
