// import 'package:flutter/material.dart';

// class FormateurFormationScreen extends StatelessWidget {
//   const FormateurFormationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("FormateurFormationScreen"),
//     );
//   }
// }
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurFormationScreen extends GetView<FormationController> {
  const FormateurFormationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Formation>>(
        stream: controller.formationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No formations available.'),
            );
          } else {
            final formations = snapshot.data!;
            return ListView.builder(
              itemCount: formations.length,
              itemBuilder: (context, index) {
                final formation = formations[index];
                return ListTile(
                  title: Text(formation.name),
                  subtitle: Text(formation.description),
                  // Add more widgets to display other formation details
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger fetching of formations
          controller.fetchFormations();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
