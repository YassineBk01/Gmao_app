import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gmao_app/pages/gestionInterventionPage.dart';
import 'package:gmao_app/pages/loginPage.dart';
import 'package:gmao_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerNavigation extends StatefulWidget {

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration:BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).accentColor.withOpacity(0.5),
                ]
            )
        ) ,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text("GMAO APP",
                  style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),


            ListTile(
              leading: Icon(Icons.content_paste, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Interventions',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ManageInterventions()),);
              },
            ),
            Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cubes, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Stocks',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
               // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.store, size: _drawerIconSize,color: Theme.of(context).accentColor),
              title: Text('Achats',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                //Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
              },
            ),
            Divider(color: Theme.of(context).primaryColor, height: 1,),
            ListTile(
              leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
              title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
              onTap: () {
                _logout();
                Navigator.push( context, MaterialPageRoute(builder: (context) => LoginPage()),);
              },
            ),
          ],
        ),
      ),
    );
  }
  void _logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> LoginPage()));
    }
  }
}
