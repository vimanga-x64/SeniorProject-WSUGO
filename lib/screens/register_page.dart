import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:wsu_go/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/screens/login_page.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  //Providing an id for routes to target
  static const String id = 'register_page';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Creating an instance for FireBase auth, _auth
  final _auth = FirebaseAuth.instance;
  //String for username, email and password that the user will enter
  String username;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/registerbackground.png'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w800,
                    )
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.only(left:30, right:30),
                  //Username field
                  child: TextField(
                    onChanged: (value) {
                      //Saving the value that the user enters in as username
                      username = value;
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.5,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: shockerYellow,
                          width: 1,
                        )
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left:30, right:30),
                  //Email field
                  child: TextField(
                    onChanged: (value) {
                      //Saving the value that the user enters in as email
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: shockerYellow,
                              width: 1,
                            )
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left:30, right:30),
                  //Password field
                  child: TextField(
                    onChanged: (value) {
                      //Saving the value that the user enters in as password
                      password = value;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: shockerYellow,
                              width: 1,
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
                  height: 25,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 70,
                      height: 45,
                        child: RaisedButton(
                          //Turning onPressed into an async method to make sure user is finished creating their fields
                          onPressed: () async{
                            //Try/Catch block to make sure all fields are correctly answered
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              if(newUser != null){
                                Navigator.pushNamed(context, HomePage.id);
                              }
                            }
                            catch (e){
                              print(e);
                            }

                          },
                          color: shockerYellow,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                    )
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
