import 'package:flutter/material.dart';

class FormateurAbsenceScreen extends StatelessWidget {
  final int number;
  const FormateurAbsenceScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seance $number"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("FormateurAbsenceScreen"),
      ),
    );
  }
}
