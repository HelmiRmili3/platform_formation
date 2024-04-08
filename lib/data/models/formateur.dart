class Formateur {
  final String name;
  final String email;
  final List<String> matiers;

  Formateur({
    required this.name,
    required this.email,
    required this.matiers,
  });

  factory Formateur.fromJson(Map<String, dynamic> json) {
    return Formateur(
      name: json['name'],
      email: json['email'],
      matiers: List<String>.from(json['matiers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'matiers': matiers,
    };
  }
}
