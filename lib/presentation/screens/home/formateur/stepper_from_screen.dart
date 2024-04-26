import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepperFormScreen extends GetView<FormationController> {
  const StepperFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Formation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller.nameController,
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.formateurController,
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Formateur'),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text('Add Seance'),
              // ),
              // const SizedBox(height: 10),
              TextField(
                controller: controller.descriptionController,
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.addFormation(),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
