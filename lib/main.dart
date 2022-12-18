import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmao_app/pages/loginPage.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor('#519DD9');
  Color _accentColor = HexColor('#0270c4');
  Color _backgroundColor = HexColor("#EDEDED");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor:_backgroundColor,
        primaryIconTheme: IconThemeData(color: Colors.white),
          primarySwatch: Colors.grey,
          inputDecorationTheme: InputDecorationTheme(

              labelStyle: TextStyle(color: Colors.blue),


          )
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isVisible = false;

  _HomePageState(){

    new Timer(const Duration(milliseconds: 3000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });
    });

    new Timer(
        Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: Image(image : AssetImage("assets/images/logo.png")),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}


