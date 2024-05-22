import 'package:myoshield/profile.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'report.dart';

class HomePage extends StatefulWidget {
  bool bluetoothalreadylistened = false;
  HomePage(bool done) {
    super.key;
    this.bluetoothalreadylistened = done;
  }
  // const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool _isButtonDisabled = false;
  String _platformVersion = 'Unknown';
  final _bluetoothClassicPlugin = BluetoothClassic();
  List<Device> _devices = [];
  List<Device> _discoveredDevices = [];
  bool _scanning = false;
  int _deviceStatus = Device.disconnected;
  Uint8List _data = Uint8List(0);
  int cnt = 0;
  int num = 0;
  double percentage = 0.0;
  int tot_sec = 0;
  int hour = 0, minute = 0, second = 0;
  int result = 0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    if (widget.bluetoothalreadylistened == false) {
      _bluetoothClassicPlugin.onDeviceStatusChanged().listen((event) {
        setState(() {
          _deviceStatus = event;
        });
      });
      _bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
        setState(() {
          _data = Uint8List.fromList([..._data, ...event]);
          // _data.clear
          tot_sec += _data[_data.length - 1];
          second = tot_sec % 60;
          minute = tot_sec ~/ 60;
          minute %= 60;
          hour = tot_sec ~/ 900;
          print(hour.toString() +
              " " +
              minute.toString() +
              " " +
              second.toString());
          print(tot_sec);
          percentage = tot_sec / 3600;
          print(_data[_data.length - 1]);
        });
      });
    }
  }

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion = "Unknown";

    try {
      platformVersion = await _bluetoothClassicPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _getDevices() async {
    await _bluetoothClassicPlugin.initPermissions();
    // if(_bluetoothClassicPlugin)
    var res = await _bluetoothClassicPlugin.getPairedDevices();
    setState(() {
      _devices = res;
    });
    _isButtonDisabled = true;
  }

  Future<void> _scan() async {
    if (_scanning) {
      await _bluetoothClassicPlugin.stopScan();
      setState(() {
        _scanning = false;
        _data = _data;
      });
    } else {
      await _bluetoothClassicPlugin.startScan();
      _bluetoothClassicPlugin.onDeviceDiscovered().listen(
        (event) {
          setState(() {
            _discoveredDevices = [..._discoveredDevices, event];
          });
        },
      );
      setState(() {
        _scanning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
      return ReportPage();
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Today's Outdoor Time",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                CircularPercentIndicator(
                  radius: 130.0,
                  lineWidth: 15.0,
                  percent: percentage,
                  center: Text(
                    (hour.toString().length == 2
                            ? hour.toString()
                            : '0' + hour.toString()) +
                        " : " +
                        (minute.toString().length == 2
                            ? minute.toString()
                            : '0' + minute.toString()) +
                        " : " +
                        (second.toString().length == 2
                            ? second.toString()
                            : '0' + second.toString()),
                    style: TextStyle(fontSize: 30.0),
                  ),
                  progressColor: Colors.yellow,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextButton(
                    // onPressed: _getDevices,
                    onPressed: _isButtonDisabled ? null : _getDevices,
                    child: Text(
                      _deviceStatus == 2
                          ? "Connected to ESP32"
                          : "Not Connected",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ...[
                  for (var device in _devices)
                    TextButton(
                      onPressed: () async {
                        await _bluetoothClassicPlugin.connect(device.address,
                            "00001101-0000-1000-8000-00805f9b34fb");
                        setState(() {
                          _discoveredDevices = [];
                          _devices = [];
                        });
                      },
                      child: Text(device.name ?? device.address),
                    )
                ],
              ],
            ),
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
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
        ),
      );
    }
  }
}
