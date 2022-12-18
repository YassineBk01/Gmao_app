
import 'package:gmao_app/pages/gestionInterventionPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gmao_app/models/intervention.dart';
import 'package:gmao_app/pages/editIntervention.dart';
import 'package:gmao_app/widgets/FilesWidget.dart';
import 'package:gmao_app/widgets/SignWidget.dart';
import 'package:gmao_app/widgets/detailsWidget.dart';
import 'package:intl/intl.dart';

class InterventionDetails extends StatefulWidget {
   Intervention intervention;
   InterventionDetails({Key? key, required this.intervention}) : super(key: key);

  @override
  State<InterventionDetails> createState() => _InterventionDetailsState();
}

class _InterventionDetailsState extends State<InterventionDetails> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      DetailsWidget(intervention: widget.intervention),
      FilesWidget(),
      SignWidget()
    ];
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.blue[800],
          title: Text(
            "Intervention n° " + widget.intervention.id, style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditIntervention(intervention : widget.intervention)),
                );
              },
              icon: Icon(Icons.edit,),
              tooltip: "Modifier",
            ),
            IconButton(
              onPressed: () {
                deleteintervention(widget.intervention.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageInterventions()),
                );
              },
              icon: Icon(Icons.delete,),
              tooltip: "Supprimer",
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.2),
                          Theme
                              .of(context)
                              .accentColor
                              .withOpacity(0.5),
                        ]
                    )
                ),
                child: Center(
                  child: Text(
                    "Intervention Mobile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black38,
                height: 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 100,
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 10,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              widget.intervention.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              DateFormat.jm().format(
                                  widget.intervention.startTime).toString() +
                                  " - " + DateFormat.jm().format(
                                  widget.intervention.endTime).toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                            )
                          ],
                        ),
                      ),


                    ),
                    Expanded(child: Container(
                      margin: EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Text(
                            "NORMAL",
                            style: TextStyle(
                              color: Colors.orange[800],
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 11,),
                          Text(
                            DateFormat("d/mm")
                                .format(widget.intervention.date)
                                .toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),

                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                color: Colors.black38,
                height: 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.intervention.isDone
                                    ? "Terminée"
                                    : "En cours",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,

                                ),
                              ),
                              Switch(
                                  value: widget.intervention.isDone,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.intervention.isDone = value;
                                    });
                                  }
                              ),
                            ],
                          ),
                          NavigationBar(

                            onDestinationSelected: (int index) {
                              setState(() {
                                currentPageIndex = index;
                              });
                            },
                            selectedIndex: currentPageIndex,
                            destinations: const <Widget>[
                              NavigationDestination(

                                icon: Icon(Icons.info_outline),
                                label: 'Details',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.attach_file_outlined),
                                label: 'Fichiers',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.check),
                                label: 'Signature',
                              ),
                            ],
                          ),

                        ],
                      ),
                    )

                  ],
                ),
              ),
              Container(
                color: Colors.black38,
                height: 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

              ),
              tabs[currentPageIndex],
            ],
          ),
        )
    );
  }
  Future deleteintervention(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/api/afriqIndusApp/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print('DELETE COMPLETE');
    } else {
      print('NOT DELETED');
    }
  }
}