import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gmao_app/models/intervention.dart';
import 'package:gmao_app/pages/InterventionDetails.dart';
import 'package:gmao_app/pages/editIntervention.dart';
import 'package:gmao_app/utils.dart';
import 'package:intl/intl.dart';


class InterventionCard extends StatefulWidget {

  final Intervention intervention;
  const InterventionCard({Key? key , required this.intervention}) : super(key: key);

  @override
  State<InterventionCard> createState() => _InterventionCardState();
}

class _InterventionCardState extends State<InterventionCard> {

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
      startActionPane: ActionPane(
          key: Key(widget.intervention.id),
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((BuildContext context) {  interventionDetails(context , widget.intervention);}),
              backgroundColor: Colors.blue.shade400,
              foregroundColor: Colors.white,
              icon: Icons.info,
              label: 'Infos',
            ),
          ]
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        key: Key(widget.intervention.id),
        children: [
          SlidableAction(
            onPressed: ((BuildContext context) { editintervention(context,widget.intervention); }),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Modifier',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {  deleteIntervetion(context, widget.intervention);},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Supprimer',
          ),

        ],



      ),

      child: buildIntervention(context),
    ),
  );

  Widget buildIntervention(BuildContext context) => Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.blue,
          spreadRadius: 2,
        )
      ]

    ),
    padding: EdgeInsets.all(20),
    child: Row(
      children: [

        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Intervention Mobile "+widget.intervention.id,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                widget.intervention.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 2,),
              Text(
                widget.intervention.adress,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12,),
              Text(
                  DateFormat.jm().format(widget.intervention.startTime).toString()+" - "+DateFormat.jm().format(widget.intervention.endTime).toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              )

            ],
          ),
        SizedBox(width: 60,),
        Expanded(
            child: Checkbox(

              activeColor: Colors.blue,
              checkColor: Colors.white,
              value: widget.intervention.isDone,
              onChanged: (bool? value) {
                setState(() {
                  widget.intervention.isDone = value!;
                });
                Utils.showSnackBar(
                    context,
                    widget.intervention.isDone  ? 'intervention terminée' : "intervention n'est pas terminée");
              },
            ),
        ),
        
      ],
    ),
  );
  void deleteIntervetion(BuildContext context, Intervention intervention) {
    //provider delete

    Utils.showSnackBar(context, "l'intervention est supprimée !");
  }
  void interventionDetails(BuildContext context, Intervention intervention) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => InterventionDetails(intervention: intervention),
    ),
  );
  void editintervention(BuildContext context, Intervention intervention) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditIntervention(intervention: intervention),
    ),
  );
}
