import 'package:flutter/material.dart';
class AppBarDeco extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height/9;
    return Container(

            height: _height,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade500,

              ]
          )
      ),
            child: Container(
              margin: EdgeInsets.only(top: _height-30),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
            ),

    );
  }
}
