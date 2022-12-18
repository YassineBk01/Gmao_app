import 'package:flutter/material.dart';
import 'package:gmao_app/models/intervention.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:gmao_app/widgets/drawerrNavigationWidget.dart';

import 'package:gmao_app/widgets/listOfInterventions.dart';



class ManageInterventions extends StatefulWidget {


  @override
  State<ManageInterventions> createState() => _ManageInterventionsState();
}

class _ManageInterventionsState extends State<ManageInterventions> {
  final String title = "Gestion Des Interventions";
  DateTime _selectedDate = DateTime.now();
  String date=DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue[800],
        title: Text( title,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Colors.white,

          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu,color: Colors.white,size: 25,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

      ),
      drawer: DrawerNavigation(),
      body: SingleChildScrollView(
        child : Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  Container(
                    height: MediaQuery.of(context).size.height/8,

                    child: DatePicker(

                      DateTime.utc(_selectedDate.year,_selectedDate.month-1,_selectedDate.day),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.blue,
                      selectedTextColor: Colors.white,
                      locale: "fr_Fr",
                      onDateChange: (dateChanged) {
                        // New date selected
                        setState(() {
                          _selectedDate = dateChanged;
                          date=_selectedDate.day.toString()+"/"+_selectedDate.month.toString()+"/"+_selectedDate.year.toString();
                        });
                      },
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.blue.shade900,
                              Colors.blue.shade500,
                              Colors.blue.shade400,
                              Colors.blue.shade300,
                            ]
                        )
                    ),
                    child: Row(
                      children: [

                        SizedBox(width: 10,),
                        Icon(Icons.calendar_month_outlined,color:Colors.white ,),
                        SizedBox(width: 15,),
                        Expanded(child: Text(
                          "Date      : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),),

                        Expanded(

                          child: Text(
                            date,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                  ),






                ],
              ),
            ),



            ListOfInterventions(date: _selectedDate),


          ],
        )

      ),
      /*floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,

        onPressed: () {},
        child: Icon(Icons.add),
      ),*/
    );
  }


}
