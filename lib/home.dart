import 'package:flutter/material.dart';
import 'package:salatdaily/dashboard.dart';
import 'package:salatdaily/dailyprayers.dart';
import 'package:salatdaily/recitation.dart';
import 'package:salatdaily/qaabalocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salatdaily/constants.dart';
import 'package:salatdaily/currentuser.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CurrentUser currentUser = new CurrentUser();

  String firstName = '';
  String lastName = '';
  String title = 'User Dashboard';
  static int _selectedindex = 0;
  List<Widget> options = <Widget>[
    Profile(),
    DailyPrayers(),
    Recitation(),
    QiblaCompass(),
  ];

  void onItemTap(int index) {
    List<String> titles = [
      'User Dashboard',
      'Prayer Times',
      'Daily Schedule',
      'Qibla Direction'
    ];
    setState(() {
      _selectedindex = index;
      title = titles[index];
    });
  }

  @override
  initState() {
    currentUser.getCurrentUser();
    getUserName();
    super.initState();
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefs.getString('firstname') != null ?
      firstName = prefs.getString('firstName');
      currentUser.lastName != null
          ? lastName = currentUser.lastName
          : lastName = ' ';
    });
    // print('FirstName and LastName of Current User:');
    // print('firstName: ${currentUser.firstName}');
    // print('lastName: ${currentUser.lastName}');
  }

  @override
  Widget build(BuildContext context) {
    getUserName();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '$title',
          style: TextStyle(
            color: Colors.white,
            //fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: kTeal,
      ),
      body: Center(
        child: options.elementAt(_selectedindex),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text(
                    '$firstName $lastName'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: kTeal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                tileColor: kLight,
                trailing: Icon(
                  Icons.history,
                  color: kGrey,
                ),
                title: Text(
                  'History',
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/history');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                tileColor: kLight,
                trailing: Icon(
                  Icons.info,
                  color: kGrey,
                ),
                title: Text(
                  'App info',
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                tileColor: kLight,
                trailing: Icon(
                  Icons.star,
                  color: kGrey,
                ),
                title: Text(
                  'Quran',
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/readQuran');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                tileColor: kLight,
                trailing: Icon(
                  Icons.exit_to_app,
                  color: kGrey,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
                onTap: () {
                  return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: kLight,
                            title: Text(
                              'You will be logged out from Learn Quran?',
                              style: TextStyle(color: kTeal, fontSize: 14),
                            ),
                            actions: [
                              RaisedButton(
                                color: kTeal,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              RaisedButton(
                                  color: kThird,
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.clear();
                                    Navigator.pop(context, true);
                                    Navigator.pushNamed(context, '/');
                                  }),
                            ],
                          ));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kTeal,
        selectedLabelStyle: TextStyle(color: kTeal),
        unselectedItemColor: kGrey,
        unselectedLabelStyle: TextStyle(color: kGrey),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              //color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.dashboard,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_rounded,
              //color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.access_time_rounded,
            ),
            label: 'Prayer',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
              //color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.today,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              //color: Colors.grey,
            ),
            activeIcon: Icon(Icons.explore),
            label: 'Qibla',
          ),
        ],
        currentIndex: _selectedindex,
        onTap: onItemTap,
      ),
    );
  }
}
