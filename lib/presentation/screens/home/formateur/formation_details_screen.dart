import 'package:eplatfrom/data/models/formation.dart';
import 'package:flutter/material.dart';

class FormationDetailsScreen extends StatefulWidget {
  final Formation formation;
  const FormationDetailsScreen({
    super.key,
    required this.formation,
  });

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
        backgroundColor: Colors.blueAccent,
        title: Text(widget.formation.name),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'absentList',
                child: Text('Absent list'),
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
          side: BorderSide(width: 0, color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2000),
            bottomRight: Radius.circular(1000)
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: SizedBox(),
        ),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: _selectedMenuItem == '',
            child: SafeArea(
              minimum: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(widget.formation.description),
              ),
            ),
          ),
          Visibility(
            visible: _selectedMenuItem == 'edit',
            child: const Center(
              child: Text("Edit Screen"),
            ),
          ),
          Visibility(
            visible: _selectedMenuItem == 'absentList',
            child: const Center(
              child: Text("Absent List Screen"),
            ),
          ),
        ],
      ),
    );
  }
}
