import 'package:wsu_go/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import './food_page.dart';

class CustomDrawer extends StatelessWidget {
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
                           Material(
                             borderRadius: BorderRadius.all(Radius.circular(50.0)),
                             elevation: 10,
                             child: Image.asset('images/wsulogo.png', width: 100, height: 100,),
                           ),
                          Padding(padding: EdgeInsets.all(5.0), 
                            child: Text('WSUGo', style: TextStyle(color: Colors.white, fontSize: 21.0),),)
                        ],
                      ),
                   )),  
                CustomListTile(Icons.home,'Home', ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()))
                      }),
                CustomListTile(Icons.fastfood,'Food', ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FoodPage()))
                      }),
                CustomListTile(Icons.event_note,'Schedule', ()=>{}),
                CustomListTile(Icons.wb_sunny_outlined,'Weather', ()=>{}),
                CustomListTile(Icons.logout,'Logout', ()=>{}),
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