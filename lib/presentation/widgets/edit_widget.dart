import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditWidget extends GetView<FormateurController> {
  final Formation formation;

  const EditWidget({required this.formation, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.nameController.text = formation.name;
    controller.descriptionController.text = formation.description;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Edit Formation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.editFormation(formation),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
