import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/stepper_from_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurFormationScreen extends GetView<FormationController> {
  const FormateurFormationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Use Obx to listen to changes in the controller
        return controller.formationsStream.value.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.formationsStream.value.length,
                itemBuilder: (context, index) {
                  final formation = controller.formationsStream.value[index];
                  return ListTile(
                    title: Text(formation.name),
                    subtitle: Text(formation.description),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(const StepperFormScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
