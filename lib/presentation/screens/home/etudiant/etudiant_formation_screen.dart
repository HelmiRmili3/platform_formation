import 'package:eplatfrom/presentation/controllers/etudiant_controller.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_formation_details_screen.dart';
import 'package:eplatfrom/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtudiantFormationScreen extends StatelessWidget {
  EtudiantFormationScreen({super.key});
  final EtudiantController controller = Get.find<EtudiantController>();

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
                          () => EtudiantDetailsScreen(
                            formation: formation,
                          ),
                        );
                      },
                      child: CustomCard(
                        title: formation.name,
                        description: formation.description,
                        imageUrl:
                            "https://img.freepik.com/free-vector/blue-curve-background_53876-113112.jpg",
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
