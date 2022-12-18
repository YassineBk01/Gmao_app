import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmao_app/models/intervention.dart';
import 'package:gmao_app/widgets/interventionWidget.dart';
import 'package:http/http.dart' as http;
class ListOfInterventions extends StatefulWidget {
 /*final interventions = [
   Intervention(id: "1", title: "Title 1", adress: "adress1 n 1 rue 1 , ville1", date: DateTime.now(), startTime: DateTime.parse("2022-10-04 07:00:00.000Z"), endTime: DateTime.parse("2022-10-04 11:00:00.000Z")),
   Intervention(id: "2", title: "Title 2", adress: "adress2 n 2 rue 2 , ville2", date: DateTime.now(), startTime: DateTime.parse("2022-10-04 17:00:00.000Z"), endTime: DateTime.parse("2022-10-04 19:00:00.000Z"),isDone: true)
 ];*/
  DateTime date;
 ListOfInterventions({Key? key, required this.date}) : super(key: key);

  @override
  State<ListOfInterventions> createState() => _ListOfInterventionsState();
}

class _ListOfInterventionsState extends State<ListOfInterventions> {
  final String _url = 'http://10.0.2.2:8000/api/afriqIndusApp';
  late Future <List<Intervention>> futureIntervention;



  @override
  void initState() {
    super.initState();
    String FormatedDate= widget.date.day.toString()+"-"+widget.date.month.toString()+"-"+widget.date.year.toString();
    futureIntervention = fetchIntervention(FormatedDate);
  }
  Widget build(BuildContext context) {

    return FutureBuilder <List<Intervention>>(
      future: futureIntervention,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Intervention>? data = snapshot.data;
          return
            ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) => Container(height: 10),
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return InterventionCard(intervention: data[index]);
              },
            );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Center(
          child: Text(
            'No interventions.',
            style: TextStyle(fontSize: 20,color: Colors.black),
          ),
        );
      },
    );

  }
  Future <List<Intervention>> fetchIntervention(String _date) async {
    final response =
    await http.get(Uri.parse(_url + '/interventions/'+_date));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Intervention.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
