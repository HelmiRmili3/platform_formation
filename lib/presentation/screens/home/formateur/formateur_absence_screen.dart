import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurAbsenceScreen extends StatefulWidget {
  final Formation formation;
  final Seance seance;
  const FormateurAbsenceScreen({
    Key? key,
    required this.seance,
    required this.formation,
  }) : super(key: key);

  @override
  State<FormateurAbsenceScreen> createState() => _FormateurAbsenceScreenState();
}

class _FormateurAbsenceScreenState extends State<FormateurAbsenceScreen> {
  final FormateurController controller = Get.find<FormateurController>();

  @override
  void initState() {
    super.initState();
    controller.fetchListAbsencePerSeance(widget.formation.id, widget.seance.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seance"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listabcense.length,
            itemBuilder: (BuildContext context, int index) {
              UserModel? etudiant = controller.listabcense[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "${index + 1} : ${etudiant.name}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        "Email: ${etudiant.email}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (etudiant != null) {
                              controller.toggleEtudiantPresence(
                                widget.formation.id,
                                widget.seance.id,
                                etudiant.id,
                              );
                            }
                          },
                          child: etudiant.present == true
                              ? const Icon(Icons.radio_button_checked)
                              : const Icon(Icons.radio_button_unchecked)),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
