import 'package:myoshield/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myoshield/profile.dart';

const List<String> list = <String>['Daily', 'Monthly', 'Myopia Progression'];

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});
  @override
  State<ReportPage> createState() {
    return _ReportPage();
  }
}

class _ReportPage extends State<ReportPage> {
  String dropdownValue = list.first;
  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 0) {
      return HomePage(true);
    } else if (selectedIndex == 2) {
      return ProfilePage();
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.yellow,
            title: Text(
              "MyoShield",
            ),
            backgroundColor: Colors.black,
          ),
          body: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
                print(dropdownValue);
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            // fixedColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text(
                    'FirstName LastName',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Disclaimer',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    // I will update the state of the app.
                  },
                ),
                ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    // I will update the state of the app.
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
