import 'package:flutter/material.dart';
import 'package:wsu_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';



class Register extends StatefulWidget {

  static const String id = 'register_page';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/loginbackground'),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
