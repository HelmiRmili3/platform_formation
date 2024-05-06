import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Seance {
  DateTime date;
  TimeOfDay time;
  String salle;
  int period;

  Seance({
    required this.date,
    required this.time,
    required this.salle,
    required this.period,
  });

  // Convert Seance instance to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
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
      date: json['date'],
      time: json['time'],
      salle: json['salle'],
      period: json['period'],
    );
  }

  // Create a Seance instance from a DocumentSnapshot
  factory Seance.fromSnapshot(DocumentSnapshot snapshot) {
    return Seance(
      date: snapshot['date'],
      time: snapshot['time'],
      salle: snapshot['salle'],
      period: snapshot['period'],
    );
  }
}
