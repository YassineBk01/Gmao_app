

import 'package:json_annotation/json_annotation.dart';

part 'intervention.g.dart';

@JsonSerializable()

class Intervention {
  /// The generated code assumes these values exist in JSON.
  final String id;
  final String title , adress,clientName,clientTitle;
  final DateTime date;
  DateTime startTime , endTime;
  bool isDone;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  String? description,clientEmail,clientPhone;

  Intervention({required this.id,required this.title,required this.adress, required this.date,  required this.startTime, required this.endTime, required this.clientName, required this.clientTitle, this.clientEmail,this.clientPhone, this.description ,this.isDone= false});

  /// Connect the generated [_$InterventionFromJson] function to the `fromJson`
  /// factory.
  factory Intervention.fromJson(Map<String, dynamic> json) => _$InterventionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InterventionToJson(this);
}