class Seance {
  final DateTime date;
  final String salle;

  Seance({
    required this.date,
    required this.salle,
  });

  factory Seance.fromJson(Map<String, dynamic> json) {
    return Seance(
      date: DateTime.parse(json['date']),
      salle: json['salle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'salle': salle,
    };
  }
}
