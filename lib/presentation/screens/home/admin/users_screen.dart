import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/presentation/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});
  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      builder: (controller) {
        return Obx(
          () {
            if (controller.users.isEmpty) {
              return const Center(
                child: Text(
                  'No users available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  UserModel user = controller.users[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                              context, controller, user);
                        },
                      ),
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

  void _showDeleteConfirmationDialog(
      BuildContext context, AdminController controller, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteUser(user.id);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
