import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eplatfrom/data/models/seance.dart';

class Formation {
  final String id;
  final String name;
  final String formateur;
  final List<Seance> seances;
  final DateTime releaseDate;
  final List<String> etudiants;
  final DateTime totalHours;
  final String description;

  Formation({
    required this.id,
    required this.name,
    required this.formateur,
    required this.seances,
    required this.releaseDate,
    required this.etudiants,
    required this.totalHours,
    required this.description,
  });

  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      id: json['id'],
      name: json['name'],
      formateur: json['formateur'],
      seances: List<Seance>.from(
          json['seances'].map((seance) => Seance.fromJson(seance))),
      releaseDate: DateTime.parse(json['releaseDate']),
      etudiants: List<String>.from(json['etudiants']),
      totalHours: DateTime.parse(json['totalHours']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'formateur': formateur,
      'seances': seances.map((seance) => seance).toList(),
      'releaseDate': releaseDate.toIso8601String(),
      'etudiants': etudiants,
      'totalHours': totalHours.toIso8601String(),
      'description': description,
    };
  }

  factory Formation.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return Formation.fromJson(json);
  }
  Formation copyWith({
    String? id,
    String? name,
    String? formateur,
    List<Seance>? seances,
    DateTime? releaseDate,
    List<String>? etudiants,
    DateTime? totalHours,
    String? description,
  }) {
    return Formation(
      id: id ?? this.id,
      name: name ?? this.name,
      formateur: formateur ?? this.formateur,
      seances: seances ?? this.seances,
      releaseDate: releaseDate ?? this.releaseDate,
      etudiants: etudiants ?? this.etudiants,
      totalHours: totalHours ?? this.totalHours,
      description: description ?? this.description,
    );
  }
}
