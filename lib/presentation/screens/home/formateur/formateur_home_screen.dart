import 'package:eplatfrom/presentation/screens/home/formateur/formateur_absence_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_formation_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_profile_screen.dart';
import 'package:flutter/material.dart';

class FormateurHomeScreen extends StatefulWidget {
  const FormateurHomeScreen({super.key});

  @override
  State<FormateurHomeScreen> createState() => _FormateurHomeScreenState();
}

class _FormateurHomeScreenState extends State<FormateurHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = const [
    FormateurFormationScreen(),
    FormateurAbsenceScreen(),
    FormateurProfileScreen()
  ];
  final List<Widget> titles = const [
    Text("Formation"),
    Text("Absence"),
    Text("Profile")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titles[_selectedIndex],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: screens[_selectedIndex],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildNavBarItem(Icons.home, 'Home', 0),
                  _buildNavBarItem(Icons.remove, 'Absence', 1),
                  _buildNavBarItem(Icons.person, 'Profile', 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: _selectedIndex == index ? Colors.blue : Colors.grey),
            Text(label,
                style: TextStyle(
                    color:
                        _selectedIndex == index ? Colors.blue : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
