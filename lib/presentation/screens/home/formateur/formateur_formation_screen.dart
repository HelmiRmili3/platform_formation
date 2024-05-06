import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formation_details_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/stepper_from_screen.dart';
import 'package:eplatfrom/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurFormationScreen extends GetView<FormateurController> {
  const FormateurFormationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.formations.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: controller.formations.length,
                itemBuilder: (context, index) {
                  final formation = controller.formations[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => FormationDetailsScreen(
                            formation: formation,
                          ),
                        );
                      },
                      child: CustomCard(
                        title: formation.name,
                        description: formation.description,
                        imageUrl:
                            "https://i.pinimg.com/originals/6a/d9/0f/6ad90fb82cf534c03ba1d8c17a3124a7.jpg",
                      ),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const StepperFormScreen()),
        backgroundColor: Colors.white,
        shape: const CircleBorder(eccentricity: 0.5),
        child: Icon(
          Icons.add,
          color: Colors.blue[900],
        ),
      ),
    );
  }
}
