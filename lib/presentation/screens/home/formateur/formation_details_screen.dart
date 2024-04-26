import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/widgets/edit_widget.dart';
import 'package:flutter/material.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                ),
              ),
            if (_selectedMenuItem == 'edit')
              EditWidget(formation: widget.formation),
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
