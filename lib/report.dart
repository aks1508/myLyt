import 'package:flutter/widgets.dart';
import 'package:myoshield/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile.dart';
import 'package:myoshield/reports/bargraphs/barchart.dart';

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
  List<double> weeklySummary = [
    4.40,
    5.5,
    40.0,
    50.0,
    60.0,
    70.0,
    80.0,
  ];
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
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_double_arrow_down_outlined),
                  elevation: 20,
                  style: TextStyle(color: Colors.black),
                  dropdownColor: Colors.yellow,
                  underline: Container(
                    height: 3,
                    color: Colors.yellow,
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
                      child: Container(
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: Text("Report Page")),
              SizedBox(
                height: 70,
              ),
              SizedBox(
                  height: 200,
                  child: BarGraph(
                    weeklySummary: weeklySummary,
                  )),
            ],
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
