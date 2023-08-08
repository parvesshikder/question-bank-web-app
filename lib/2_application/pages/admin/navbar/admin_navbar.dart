import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/admin/admin_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:questionbankleggasi/2_application/core/constants/imagepath_constants.dart';
import 'dart:html' as html;

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({Key? key}) : super(key: key);

  @override
  _AdminNavbarState createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  var fireAuth = FirebaseAuth.instance;
  bool isMenuOpen = true; // Set initial value to false
  int selectedIndex = 0;

  late SharedPreferences _prefs;
  static const String kSelectedIndexKey = 'selectedIndex'; // Updated key name

  @override
  void initState() {
    super.initState();
    loadSelectedIndex();
  }

  Future<void> loadSelectedIndex() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = _prefs.getInt(kSelectedIndexKey) ?? 0;
    });
  }

  Future<void> saveSelectedIndex(int index) async {
    setState(() {
      selectedIndex = index;
    });
    await _prefs.setInt(kSelectedIndexKey, index);
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: toggleMenu,
        ),
        title: Container(
          height: 60,
          child: Image.asset(
            logo, // Make sure 'logo' is defined
            fit: BoxFit.contain,
          ),
        ),
      ),
      drawer: isMenuOpen
          ? Drawer(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Home'),
                    tileColor: selectedIndex == 0 ? Colors.grey[200] : null,
                    onTap: () {
                      setState(() {
                        saveSelectedIndex(0);
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    onTap: () async {
                      setState(() async {
                        await fireAuth.signOut();
                        html.window.location.reload();
                      });
                      
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          if (isMenuOpen)
            Container(
              width: 300,
              child: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dashboard),
                      title: const Text('Home'),
                      tileColor: selectedIndex == 0 ? Colors.grey[200] : null,
                      onTap: () {
                        setState(() {
                          saveSelectedIndex(0);
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log Out'),
                      onTap: () async {
                        setState(() async {
                          await fireAuth.signOut();
                          html.window.location.reload();
                        });
                        
                      },
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: AdminDashboard(),
          ),
        ],
      ),
    );
  }
}
