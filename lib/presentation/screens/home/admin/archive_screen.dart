import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveScreen extends StatelessWidget {
  ArchiveScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      builder: (controller) {
        return Obx(
          () {
            if (controller.formationsArchive.isEmpty) {
              return const Center(
                child: Text(
                  'No formations available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.formationsArchive.length,
                itemBuilder: (context, index) {
                  Formation formation = controller.formationsArchive[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(formation.name),
                      subtitle: Text(formation.formateur),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.delete),
                      //   onPressed: () {
                      //     _showDeleteConfirmationDialog(
                      //         context, controller, formation);
                      //   },
                      // ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
