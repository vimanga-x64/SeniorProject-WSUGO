import 'package:wsu_go/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import './food_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './login_page.dart';
import './calendar_page.dart';
import './weather.dart';
import './course_page.dart';

class CustomDrawer extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Drawer menu creation
    return Drawer(
            child: ListView(
              children: [
                //Header box creation and stylization
                DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[shockerYellow, shockerYellow])
                    ),
                    child: Container (
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20
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
        CustomListTile(Icons.wb_sunny,'Weather', ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WeatherApp()))
        }),
        CustomListTile(Icons.book,'Courses', ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CoursePage()))
        }),
        //Icons.logout
        CustomListTile(Icons.exit_to_app,'Logout', 
                  ()=>{{_auth.signOut(), Navigator.pushNamed(context, Login.id)}}),
        ],)    
    );
  }
}

//Class for stylization and function of tiles
class CustomListTile extends StatelessWidget{

  //Constructor for custom variables
  CustomListTile(this.icon,this.text, this.onTap);

  //Custom variables
  IconData icon;
  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Tile border stylization
      padding: const EdgeInsets.all(9),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade600))
         ),
        child: InkWell(
          splashColor: shockerYellow,
         //Get the custom route
         onTap: onTap,
          child: Container(
            //Height of each tile
           height: 50,
           child: Row(
             //Align arrows on the far right
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                  children: [
                    //Get the custom icon
                    Icon(icon),
                   Padding(
                     //Title stylization
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      //Get custom title text
                      child: Text(text, style: TextStyle(
                      fontSize: 18.0
                    ),),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ),
      ),
    );
  }
}
