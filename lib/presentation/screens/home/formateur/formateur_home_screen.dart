import 'package:eplatfrom/presentation/screens/home/formateur/formateur_formation_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_profile_screen.dart';
import 'package:flutter/material.dart';

class FormateurHomeScreen extends StatefulWidget {
  const FormateurHomeScreen({Key? key}) : super(key: key);

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

  final List<Widget> screens = [
    FormateurFormationScreen(),
    FormateurProfileScreen()
  ];
  final List<String> titles = const [
    "Formation",
    "Profile",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavBarItem(Icons.home, 'Formation', 0),
                _buildNavBarItem(Icons.person, 'Profile', 1),
              ],
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
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.black : Colors.grey[400],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color:
                    _selectedIndex == index ? Colors.black : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
