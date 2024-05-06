import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormationScreen extends StatelessWidget {
  FormationScreen({super.key});
  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      builder: (controller) {
        return Obx(
          () {
            if (controller.formations.isEmpty) {
              return const Center(
                child: Text(
                  'No formations available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.formations.length,
                itemBuilder: (context, index) {
                  Formation formation = controller.formations[index];
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

//   void _showDeleteConfirmationDialog(
//       BuildContext context, AdminController controller, Formation formation) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Formation'),
//           content: Text('Are you sure you want to delete ${formation.name}?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
