// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intervention _$InterventionFromJson(Map<String, dynamic> json) => Intervention(
      id: json['id'] as String,
      title: json['title'] as String,
      adress: json['adress'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      clientName: json['clientName'] as String,
      clientTitle: json['clientTitle'] as String,
      clientEmail: json['clientEmail'] as String?,
      clientPhone: json['clientPhone'] as String?,
      description: json['description'] as String?,
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$InterventionToJson(Intervention instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'adress': instance.adress,
      'clientName': instance.clientName,
      'clientTitle': instance.clientTitle,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'isDone': instance.isDone,
      'description': instance.description,
      'clientEmail': instance.clientEmail,
      'clientPhone': instance.clientPhone,
    };
