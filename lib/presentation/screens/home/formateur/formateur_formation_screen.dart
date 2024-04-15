import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/stepper_from_screen.dart';
import 'package:eplatfrom/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurFormationScreen extends GetView<FormationController> {
  const FormateurFormationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.formationsStream.value.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.formationsStream.value.length,
                itemBuilder: (context, index) {
                  final formation = controller.formationsStream.value[index];
                  // return ListTile(
                  //   title: Text(formation.name),
                  //   subtitle: Text(formation.description),
                  // );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCard(
                      title: formation.name,
                      description: formation.description,
                      imageUrl:"https://i.pinimg.com/originals/6a/d9/0f/6ad90fb82cf534c03ba1d8c17a3124a7.jpg"
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const StepperFormScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
