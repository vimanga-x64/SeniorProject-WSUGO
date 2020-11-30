//// Import the firebase_auth plugin
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wsu_go/screens/register_page.dart';
import 'package:wsu_go/screens/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  //Providing an id for routes to target
  static const String id = 'login_page';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Creating an instance for FireBase auth, _auth
  final _auth = FirebaseAuth.instance;
  //String for email and password that the user will enter
  String email;
  String password;

  //Bool for progress HUD
  bool showSpinner = false;

  //Key for our form to submit
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      //Decoration property to set our static background image
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            //Our Form is wrap around the container widget
            child: Form(
              //Declaring our formKey as key to this form
              key: formKey,
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
                    Image.asset('images/logo3x.png'),
                    //WU LOGO
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: Image.asset('images/wsulogo.png'),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //Email Field
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        onChanged: (value) {
                          //Saving the value that the user enters in as email
                          email = value;
                        },
                        validator: (String value){
                          return !value.contains('@') ? 'Not a valid Email' : null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white),
                        //Decoration property to customize box appearance regarding color and when users click on it
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.5
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: shockerYellow,
                                  width: 1
                              )
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          errorStyle: TextStyle(
                            color: shockerYellow,
                            fontSize: 15,
                          ),
                        ),
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Password Field
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        onChanged: (value) {
                          //Saving the value that the user enters in as password
                          password = value;
                        },
                        validator: (String value){
                          return value.isEmpty ? 'Please enter in a Password' : null;
                        },
                        obscureText: true,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white),
                        //Decoration property to customize box appearance regarding color and when users click on it
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.5
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: shockerYellow,
                                  width: 1
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
                        onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
                              Navigator.pushNamed(context, Register.id);
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
                            //Turning onPressed into an async method to make sure user is finished creating their fields
                            onPressed: () async {
                              //If statement to check the form's validator
                              if (formKey.currentState.validate()) {
                                //Setting the spinner animation to true
                                setState(() {
                                  showSpinner = true;
                                });
                                //Using .signInWithEmailAndPassword.then.catchError to handle password/email authentication
                                _auth.signInWithEmailAndPassword(email: email, password: password).then((results){
                                  //Push user to homepage when authenticated
                                  Navigator.pushNamed(context, HomePage.id);
                                }).catchError((error){
                                  //Print error message in log
                                  print(error.message);
                                  //Show dialog to user about the specific error
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(error.message),
                                            actions: [
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                  },
                                              )
                                            ]
                                        );
                                      }
                                    );
                                  });
                                //Setting spinner animation to false
                                  setState(() {
                                    showSpinner = false;
                                  });
                              }
                            },
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
        ),
      ),
    );
  }
}
