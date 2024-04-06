import 'package:flutter/material.dart';
import 'archive_screen.dart';
import 'formation_screen.dart';
import 'profile_screen.dart';
import 'users_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = const [
    FormationScreen(),
    UsersScreen(),
    ArchiveScreen(),
    ProfileScreen()
  ];
  
  final List<Widget> titles = const [
    Text("Formation"),
    Text("Users"),
    Text("Archive"),
    Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 450) {
            return AppBar();
          } else {
            return AppBar(
              title: titles[_selectedIndex],
              centerTitle: true,
            );
          }
        }),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 450) {
            // Display as Row if screen width is greater than 600
            return _buildRowLayout();
          } else {
            // Display as Column if screen width is less than or equal to 600
            return _buildColumnLayout();
          }
        },
      ),
    );
  }

  Widget _buildRowLayout() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildNavBarItem(Icons.home, 'Home', 0),
                const SizedBox(height: 40),
                _buildNavBarItem(Icons.person, 'Users', 1),
                const SizedBox(height: 40),
                _buildNavBarItem(Icons.archive, 'Archive', 2),
                const SizedBox(height: 40),
                _buildNavBarItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: screens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnLayout() {
    return Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildNavBarItem(Icons.home, 'Home', 0),
                _buildNavBarItem(Icons.person, 'Users', 1),
                _buildNavBarItem(Icons.archive, 'Archive', 2),
                _buildNavBarItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
        ],
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