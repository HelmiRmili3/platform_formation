import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_absence_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_formation_screen.dart';
import 'package:eplatfrom/presentation/widgets/data_time_picker.dart';
import 'package:eplatfrom/presentation/widgets/edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormationDetailsScreen extends StatefulWidget {
  final Formation formation;

  const FormationDetailsScreen({
    Key? key,
    required this.formation,
  }) : super(key: key);
  @override
  State<FormationDetailsScreen> createState() => _FormationDetailsScreenState();
}

class _FormationDetailsScreenState extends State<FormationDetailsScreen> {
  String _selectedMenuItem = '';
  late Formation formation;
  late List<Seance?> seances;
  late List<UserModel?> etudiants;

  final FormateurController controller = Get.find<FormateurController>();

  @override
  void initState() {
    super.initState();
    formation = widget.formation;
    controller.fetchSeances(formation.id).then((seancesList) {
      setState(() {
        seances = seancesList;
      });
    }).catchError((error) {
      debugPrint('Error fetching seances: $error');
    });
    controller.fetchEtudiantsList(formation.id).then((value) {
      setState(() {
        etudiants = value;
      });
    }).catchError((error) {
      debugPrint('Error fetching etudiants: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        title: Text(
          formation.name.toUpperCase(), // Access formation directly
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            iconColor: Colors.white,
            icon: const Icon(
              Icons.more_vert,
              size: 30,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Seances',
                child: Text(
                  'Sessions',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'etudiants',
                child: Text(
                  'Etudiants',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            onSelected: (String value) {
              setState(() {
                _selectedMenuItem = value;
              });
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(
              // child: Text("Formateur"),
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedMenuItem == '')
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      "https://lechotunisien.com/wp-content/uploads/2023/07/formation-professionnelle.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      formation.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      formation.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Formateur: ${formation.formateur}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Release Date: ${formation.releaseDate.toString()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total Hours: ${formation.totalHours.toString()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formation.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                                minimum: const EdgeInsets.all(16),
                                child:
                                    DateTimePickerWidget(formation: formation));
                          },
                        );
                      },
                      child: const Text("Add Seance"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.deleteFormation(formation.id);
                        Get.to(() => const FormateurFormationScreen());
                      },
                      child: const Text("Delete Formation"),
                    )
                  ],
                ),
              ),
            if (_selectedMenuItem == 'edit') EditWidget(formation: formation),
            if (_selectedMenuItem == 'Seances')
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sessions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: seances.length,
                      itemBuilder: (BuildContext context, int index) {
                        Seance seance = seances[index]!;
                        DateTime dateTime =
                            DateTime.parse(seance.date.toString());
                        int year = dateTime.year;
                        int month = dateTime.month;
                        int day = dateTime.day;

                        return GestureDetector(
                          onTap: () => Get.to(() => FormateurAbsenceScreen(
                                seance: seance,
                                formation: widget.formation,
                              )),
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                "Salle ${seance.salle.toString()}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(
                                "Date : $year - $month - $day , Time ${seance.time.hour}:${seance.time.minute} ",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            if (_selectedMenuItem == 'etudiants')
              Container(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: etudiants
                      .length, // Use null-aware operators to handle null case
                  itemBuilder: (BuildContext context, int index) {
                    // Ensure etudiants is not null
                    UserModel etudiant = etudiants[index]!;
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          "${index + 1} : ${etudiant.name.toString()}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "Email :${etudiant.email.toString()}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
