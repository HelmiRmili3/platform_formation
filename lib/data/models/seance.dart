import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Seance {
  String id; // New field for the document ID
  DateTime date;
  TimeOfDay time;
  String salle;
  int period;

  Seance({
    required this.id, // Updated constructor to include the ID
    required this.date,
    required this.time,
    required this.salle,
    required this.period,
  });

  // Convert Seance instance to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Added ID to JSON representation
      'date': date.toIso8601String(),
      'time':
          '${time.hour}:${time.minute.toString().padLeft(2, '0')}', // Assuming context is available for formatting TimeOfDay
      'salle': salle,
      'period': period,
    };
  }

  // Create a Seance instance from a Map
  factory Seance.fromJson(Map<String, dynamic> json) {
    return Seance(
      id: json['id'], // Updated factory constructor to include ID
      date: json['date'],
      time: json['time'],
      salle: json['salle'],
      period: json['period'],
    );
  }

  // Create a Seance instance from a DocumentSnapshot
  factory Seance.fromSnapshot(DocumentSnapshot snapshot) {
    // Parsing 'date' field as a string in ISO 8601 format
    DateTime dateTime = DateTime.parse(snapshot['date']);

    // Parsing 'time' field as a string in 'HH:mm' format
    List<String> timeParts = snapshot['time'].split(':');
    TimeOfDay timeOfDay = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    return Seance(
      id: snapshot.id, // Extracting the document ID
      date: dateTime,
      time: timeOfDay,
      salle: snapshot['salle'],
      period: snapshot['period'],
    );
  }
}
