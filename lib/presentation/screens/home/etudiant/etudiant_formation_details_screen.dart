import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/etudiant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtudiantDetailsScreen extends StatefulWidget {
  final Formation formation;

  const EtudiantDetailsScreen({
    Key? key,
    required this.formation,
  }) : super(key: key);
  @override
  State<EtudiantDetailsScreen> createState() => _FormationDetailsScreenState();
}

class _FormationDetailsScreenState extends State<EtudiantDetailsScreen> {
  String _selectedMenuItem = '';
  final EtudiantController controller = Get.find<EtudiantController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        title: Text(
          widget.formation.name.toUpperCase(),
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
                value: 'Seances',
                child: Text(
                  'Sessions',
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
                      widget.formation.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.formation.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Formateur: ${widget.formation.formateur}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Release Date: ${widget.formation.releaseDate.toString()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total Hours: ${widget.formation.totalHours.toString()}',
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
                      widget.formation.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
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
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              "Session Title $index",
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              "Session Date $index",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
