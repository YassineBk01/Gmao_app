import 'package:flutter/material.dart';
import 'package:gmao_app/models/intervention.dart';
import 'package:gmao_app/pages/mapAdress.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailsWidget extends StatelessWidget {
  Intervention intervention;
 DetailsWidget({Key? key , required this.intervention}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 5),
        width: _width,
        child: Column(


          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       padding: EdgeInsets.only(top: 3,bottom: 3),
          width: _width*0.43,
          color: Colors.blue,
          child: Center(
            child: Text(
              "Planifié",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),),
          )

            ),
                     Container(
                       margin: EdgeInsets.all(7),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Heures : "+FormatTTime(intervention.startTime)+"-"+FormatTTime(intervention.endTime),style:TextStyle(color: Colors.grey.shade600) ,),
                           SizedBox(height: 5,),
                           Text("Temps travaillé : "+differenceTime(intervention.startTime, intervention.endTime),style:TextStyle(color: Colors.grey.shade600) ,),
                           SizedBox(height: 5,),
                            Text("Commentaire :  \n"+intervention.description.toString(),style:TextStyle(color: Colors.grey.shade600)) ,
                           SizedBox(height: 5,),
                         ],
                       ),
                     )
                   ],
                 ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 3,bottom: 3),
                        width: _width*0.43,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            "Effectué",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),),
                        )),
                    Container(
                      margin: EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("-Heures : "+FormatTTime(intervention.startTime)+"-"+FormatTTime(intervention.endTime),style:TextStyle(color: Colors.grey.shade600) ,),
                          SizedBox(height: 5,),
                          Text("-Temps travaillé : "+differenceTime(intervention.startTime, intervention.endTime),style:TextStyle(color: Colors.grey.shade600) ,),
                          SizedBox(height: 5,),
                        Text("-Commentaire :  \n"+intervention.description.toString(),style:TextStyle(color: Colors.grey.shade600)) ,
                          SizedBox(height: 5,),
                        ],
                      ),
                    )
                  ],
                ),
              ]
            ),
            Column(

              children: [
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 4),
                  width: _width*0.90,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Client",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                      ),

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 7),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("-Nom complet: "+intervention.clientName,style:TextStyle(color: Colors.grey.shade600) ,),
                      SizedBox(height: 5,),
                      Text("-Titre : "+intervention.clientTitle,style:TextStyle(color: Colors.grey.shade600) ,),
                      SizedBox(height: 5,),
                      Text("-Société :  "+intervention.clientTitle,style:TextStyle(color: Colors.grey.shade600)) ,
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("-Email :  ",style:TextStyle(color: Colors.grey.shade600)),
                          InkWell(
                            child: Text(
                              intervention.clientEmail.toString(),
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () async {
                              String toEmail = intervention.clientEmail.toString();


                              final Uri email = Uri(
                                scheme: 'mailto',
                                path: toEmail,
                              );

                              if(await canLaunchUrl(email)) {
                                await launchUrl(email);
                              } else {
                                debugPrint('error');
                              }
                            },
                          ),
                        ],
                      ) ,
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("-Téléphone :  ",style:TextStyle(color: Colors.grey.shade600)),
                          InkWell(
                            child: Text(
                              intervention.clientPhone.toString(),
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () async {
                                  String toEmail = intervention.clientPhone.toString();

                                  final Uri email = Uri(
                                  scheme: 'tel',
                                  path: toEmail,
                                  );

                                  if(await canLaunchUrl(email)) {
                                  await launchUrl(email);
                                  } else {
                                  debugPrint('error');
                                  }}
                          )
                        ],
                      ) ,

                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: _width*0.5,
              height: MediaQuery.of(context).size.height/19,
              child: FlatButton(

                  color: Colors.blue[700],
                  padding: EdgeInsets.all(5),
                  onPressed: (){},
                  child:  Align(
                    alignment: Alignment.center,
                    child: Text(
                        "Envoyer le rapport au client",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center
                      ),
                  ),

              ),
            ),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 4),
                  width: _width*0.90,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Adresse",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                      ),

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()),);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(intervention.adress,style:TextStyle(color: Colors.grey.shade600) ,),
                        SizedBox(width: 7,),
                        Icon(Icons.maps_home_work,color: Colors.blue[800],),
                        SizedBox(width: 5,),
                        Text("Voir la carte",style: TextStyle(
                          color: Colors.blue[800],
                        ),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 4),
                  width: _width*0.90,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Pièces jointes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),

                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

          ],
        )


    );
  }
  String FormatTTime(DateTime time){
    return DateFormat('HH:mm').format(time).toString();
  }
  String differenceTime(DateTime timeStart, DateTime timeEnd){
    int minutes = timeEnd.difference(timeStart).inMinutes;
    int hours = (minutes ~/ 60 );
    return (hours.toString()+":"+(minutes-hours*60).toString());
  }
}
