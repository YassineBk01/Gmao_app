import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gmao_app/models/intervention.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditIntervention extends StatefulWidget {
  Intervention intervention;
   EditIntervention({Key? key,required this.intervention}) : super(key: key);

  @override
  State<EditIntervention> createState() => _EditInterventionState();
}


class _EditInterventionState extends State<EditIntervention> {
  var debut,fin,durre,client,title,comment;
  final String _url = 'http://10.0.2.2:8000/api/afriqIndusApp';

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[800],
        title: Text("Intervention  "+widget.intervention.title , style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),),

      ),
      body:  Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilder(

                    key: _formKey,
                    // enabled: false,
                    onChanged: () {
                    _formKey.currentState!.save();
                    debugPrint(_formKey.currentState!.value.toString());},
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,

                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
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
                              "Heures   : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),),


                          ],
                        ),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                      ),
                      FormBuilderDateTimePicker(

                        name: 'debut ',
                        initialTime: TimeOfDay(hour: widget.intervention.startTime.hour, minute: widget.intervention.startTime.minute),
                        inputType: InputType.time,
                        initialValue: widget.intervention.startTime,
                        decoration: const InputDecoration(
                          labelText: "Début",
                        ),
                        onSaved: (value){
                              debut=value;

                        },
                      ),
                      SizedBox(height: 10,),
                      FormBuilderDateTimePicker(

                        name: 'fin ',
                        initialTime: TimeOfDay(hour: widget.intervention.endTime.hour, minute: widget.intervention.endTime.minute),
                        inputType: InputType.time,
                        initialValue: widget.intervention.endTime,
                        decoration: const InputDecoration(
                          labelText: "Fin",
                        ),
                        onSaved: (value){
                          fin =value;
                        },
                      ),
                      SizedBox(height: 10,),
                      FormBuilderDateTimePicker(

                        name: 'duree ',
                        initialTime: TimeOfDay(hour: 00, minute: 00),
                        inputType: InputType.time,
                        initialValue: DateTime(20022,7,30,00,00),
                        decoration: const InputDecoration(
                          labelText: "Temps de travail",
                        ),
                        onSaved: (value){
                            durre =value;
                        },
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
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
                            Icon(Icons.person,color:Colors.white ,),
                            SizedBox(width: 15,),
                            Expanded(child: Text(
                              "Client   : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),),


                          ],
                        ),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                      ),
                      FormBuilderTextField(
                        cursorColor: Colors.blue,

                        name: "client",
                        initialValue: widget.intervention.clientTitle,
                        onSaved: (value){
                                client=value;
                        },
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
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
                            Icon(Icons.title,color:Colors.white ,),
                            SizedBox(width: 15,),
                            Expanded(child: Text(
                              "Titre   : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),),


                          ],
                        ),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                      ),
                      FormBuilderTextField(
                        cursorColor: Colors.blue,
                        name: "titre",
                        initialValue: widget.intervention.title,
                        onSaved: (value){
                                title= value;
                        },

                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
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
                            Icon(Icons.comment,color:Colors.white ,),
                            SizedBox(width: 15,),
                            Expanded(child: Text(
                              "Commentaire  : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),),


                          ],
                        ),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                      ),
                      FormBuilderTextField(
                        cursorColor: Colors.blue,
                        maxLines: 4,
                        name: "commentaire",
                        initialValue: widget.intervention.description.toString(),
                        onSaved: (value){
                          comment=value;
                        },
                      ),

                      SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade700,
                        ),

                        onPressed: (){
                          _formKey.currentState?.saveAndValidate();
                          updateIntervention(debut, fin, client, title, comment);
                          Navigator.pop(context);
                        },
                        child: Padding(

                          padding: const EdgeInsets.all(8),
                          child: Text("Enregitrer",style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),),
                        ),
                      ),
                      





                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
  Future<Intervention> updateIntervention(debut,fin,client,title,comment) async {
    final response = await http.put(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'startTime': debut,
        'endTime': fin,
        'clientTitle': client,
        'description':comment,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Intervention.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update intervention.');
    }
  }
}
