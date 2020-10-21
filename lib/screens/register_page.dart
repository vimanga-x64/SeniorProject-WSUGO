import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:wsu_go/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/screens/login_page.dart';
// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  //Bool for progress HUD
  bool showSpinner = false;

  //Key for our form to submit
  var formKey = GlobalKey<FormState>();

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
        //Wrapping the body of our Scaffold with ModalProgressHUD to show spinner
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            //Our Form is wrap around the container widget
            child: Form(
              //Declaring our formKey as key to this form
              key: formKey,
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
                      child: TextFormField(
                        onChanged: (value) {
                          //Saving the value that the user enters in as username
                          username = value;
                        },
                        //Validator for the field
                        validator: (String value){
                          return value.isEmpty ? 'Please enter in a Username' : null;
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
                          ),
                          errorStyle: TextStyle(
                            color: shockerYellow,
                            fontSize: 15,
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
                      child: TextFormField(
                        onChanged: (value) {
                          //Saving the value that the user enters in as email
                          email = value;
                        },
                        //Validator for the field
                        validator: (String value){
                          return !value.contains('@') ? 'Not a valid Email' : null;
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
                            ),
                            errorStyle: TextStyle(
                              color: shockerYellow,
                              fontSize: 15,
                            ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.only(left:30, right:30),
                      //Password field
                      child: TextFormField(
                        onChanged: (value) {
                          //Saving the value that the user enters in as password
                          password = value;
                        },
                        //validator for the field
                        validator: (String value){
                          return value.isEmpty ? 'Please enter in a Password' : null;
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
                            ),
                            errorStyle: TextStyle(
                              color: shockerYellow,
                              fontSize: 15,
                            ),
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
                                //If statement to check the form's validator
                                if(formKey.currentState.validate()) {

                                  //Setting the state of the spinner to True
                                  setState(() {
                                    showSpinner = true;
                                  });

                                  //Try/Catch block to make sure all fields are correctly answered
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    if (newUser != null) {
                                      Navigator.pushNamed(context, HomePage.id);
                                    }

                                    //Setting the state of the spinner to false after pushing user
                                    setState(() {
                                      showSpinner = false;
                                    });

                                  }
                                  catch (e) {
                                    print(e);
                                  }
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
        ),
      ),
    );
  }
}
