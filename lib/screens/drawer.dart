import 'package:wsu_go/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import './food_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wsu_go/screens/login_page.dart';
import './calendar_page.dart';
import './weather.dart';

class CustomDrawer extends StatelessWidget {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        shockerYellow,
                        shockerYellow
                      ])
                    ),
                    child: Container (
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                           Material(
                             borderRadius: BorderRadius.all(Radius.circular(50.0)),
                             elevation: 10,
                             child: Image.asset('images/logo3x.png'),
                           ),
                        ],
                      ),
                   )),  
                CustomListTile(Icons.home,'Home', ()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()))
                }),
                CustomListTile(Icons.fastfood,'Food', ()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FoodPage()))
                }),
                CustomListTile(Icons.event_note,'Calendar', ()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CalendarPage()))
                }),
                //Icons.wb_sunny_outlined
                CustomListTile(Icons.wb_sunny,'Weather', ()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherApp()))
                }),
                //Icons.logout
                CustomListTile(Icons.exit_to_app,'Logout', 
                  ()=>{{_auth.signOut(), Navigator.pushNamed(context, Login.id)}}),
            ],)
          );
  }
}

class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon,this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
         ),
        child: InkWell(
          splashColor: shockerYellow,
         onTap: onTap,
          child: Container(
           height: 50,
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                  children: [
                    Icon(icon),
                   Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: Text(text, style: TextStyle(
                      fontSize: 16.0
                    ),),
                  ),
                ],
              ),
              Icon(Icons.arrow_right)
            ],
          ),
        ),
      ),
      ),
    );
  }
}