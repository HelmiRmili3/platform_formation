import 'package:flutter/material.dart';

class StepperFormScreen extends StatelessWidget {
  const StepperFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Formation"),
      ),
      body: const Center(
        child: Text("form"),
      ),
    );
  }
}
