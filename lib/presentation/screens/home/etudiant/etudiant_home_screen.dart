import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_formation_screen.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_profile_screen.dart';
import 'package:flutter/material.dart';

class EtudiantHomeScreen extends StatefulWidget {
  const EtudiantHomeScreen({super.key});

  @override
  State<EtudiantHomeScreen> createState() => _EtudiantHomeScreenState();
}

class _EtudiantHomeScreenState extends State<EtudiantHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = const [
    EtudiantFormationScreen(),
    EtudiantProfileScreen()
  ];
  final List<Widget> titles = const [Text("Formation"), Text("Profile")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titles[_selectedIndex],
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  _buildNavBarItem(Icons.person, 'Profile', 1),
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
