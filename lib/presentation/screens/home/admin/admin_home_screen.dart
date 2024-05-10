import 'package:eplatfrom/presentation/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'archive_screen.dart';
import 'formation_screen.dart';
import 'profile_screen.dart';
import 'users_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({Key? key}) : super(key: key);
  final AdminController controller = Get.find<AdminController>();

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

  final List<Widget> screens = [
    FormationScreen(),
    UsersScreen(),
    const ArchiveScreen(),
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
              automaticallyImplyLeading: false,
            );
          }
        }),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 450) {
            return _buildRowLayout();
          } else {
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
