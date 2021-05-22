import 'package:flutter/material.dart';
import 'package:salatdaily/currentuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salatdaily/constants.dart';
import 'package:salatdaily/historymanager.dart';
import 'package:salatdaily/prayertimes.dart';
//import 'package:salatdaily/dailyPrayers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const spinkit = SpinKitFadingCircle(
    color: kTeal,
    size: 50.0,
  );
  List<String> englishNames = [
    'FAJAR',
    'SUNRISE',
    'ZUHAR',
    'ASAR',
    'MAGHRIB',
    'ISHA',
  ];
  List<String> urduNames = ['فجر', 'طلوع آفتاب', 'ظهر', 'عصر', 'مغرب', 'عشاء'];
  PrayerTimes prayerTimes = PrayerTimes();
  double lat;
  double lon;
  String whichMonth;
  int whichDay;
  int dayIndex;
  String whichYear;
  int nextPrayerIndex;
  String nextPrayerTime;
  String currentPrayerTime;
  int currentPrayerIndex;

  HistoryManager historyManager = new HistoryManager();
  int skipCount = 0;
  int readCount = 0;
  int absentCount = 0;

  CurrentUser currentUser = new CurrentUser();
  bool myturn = false;
  bool isLoaded = false;
  List<String> surahName = [];
  List<String> verses = [];
  List<int> verseNumber = [];
  List<int> parahNumber = [];
  List<String> translations = [];

  //presentation details
  String firstName = 'Faruq';
  String lastName = 'Al Tayyib';
  String date = '14-08-1947';
  String prayerTime = 'prayer time';
  String prayerName = 'Dhuhr';
  String status = 'un-read';
  String a, b;
  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
    fetchUserActivity();
    fetchNextPrayer();
  }

  fetchNextPrayer() async {
    String currentDate = ('${DateTime.now().toLocal()}'.split(' ')[0]);
    await prayerTimes.getCurrentLocation();
    setState(() {
      lat = prayerTimes.latitude;
      lon = prayerTimes.longitude;
      whichMonth = currentDate.split('-')[1];
      whichDay = int.parse(currentDate.split('-')[2]);
      dayIndex = whichDay - 1;
      whichYear = currentDate.split('-')[0];
    });
    await prayerTimes.getPrayerTimes(lat, lon, dayIndex, whichMonth, whichYear);
    setState(() {
      nextPrayerIndex = prayerTimes.nextPrayer();
      nextPrayerIndex != 0
          ? currentPrayerIndex = (nextPrayerIndex - 1)
          : currentPrayerIndex = 5;
      print('Next Prayer Index: $nextPrayerIndex');
      nextPrayerTime = prayerTimes.times[nextPrayerIndex];
      currentPrayerTime = prayerTimes.times[currentPrayerIndex];
      print(nextPrayerTime);
    });
  }

  fetchUserActivity() async {
    await historyManager.getHistory();
    setState(() {
      skipCount = historyManager.skipCount;
      readCount = historyManager.readCount;
      absentCount = historyManager.absentCount;
    });
  }

  read() async {
    var isread = await currentUser.read();
    setState(() {
      isread ? status = 'read' : status = 'unread';
      myturn = false;
      Navigator.pop(context, false);
    });
  }

  skip() async {
    var isskipped = await currentUser.skipTurn();
    setState(() {
      isskipped ? status = 'skiped' : status = 'unread';
      myturn = false;
      Navigator.pop(context, false);
    });
  }

  fetchCurrentUser() async {
    await currentUser.getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser.surahName.forEach((element) {
        surahName.add(element);
      });
      currentUser.verses.forEach((element) {
        verses.add(element);
      });
      currentUser.translations.forEach((element) {
        translations.add(element);
      });
      currentUser.verseNumber.forEach((element) {
        verseNumber.add(element);
      });
      currentUser.parahNumber.forEach((element) {
        parahNumber.add(element);
      });
      firstName = currentUser.firstName;
      lastName = currentUser.lastName;
      prefs.setString('firstName', firstName);
      prefs.setString('lastName', lastName);
      prefs.reload();
      print(firstName);
      print(lastName);

      date = currentUser.date;
      prayerTime = currentUser.prayerTime;
      a = prayerTime.split(':')[0];
      //print(a);
      b = prayerTime.split(':')[1].split(' ')[0];
      // print(b);
      // print('PrayerTime is: $prayerTime');
      TimeOfDay time = TimeOfDay(hour: int.parse(a), minute: int.parse(b));
      print(time.hour);
      print(time.minute);
      print(time);
      prayerName = currentUser.prayerName;
      isLoaded = true;
      myturn = currentUser.myturn;
    });
  }

  activityButton(
    String title,
    Function function,
    Color color,
  ) {
    return RaisedButton(
      color: color,
      child: Text(
        'Mark $title',
        style: TextStyle(color: kGrey, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: kLight,
                  title: Text(
                    'You are about to $title your verse(s). Do you want to proceed?',
                    style: TextStyle(color: kTeal, fontSize: 14),
                  ),
                  actions: [
                    RaisedButton(
                      color: kSecond,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    RaisedButton(
                      color: kTeal,
                      child: Text(
                        'Mark $title',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () {
                        //Navigator.pop(context, false);
                        return function();
                      },
                    ),
                  ],
                ));
      },
    );
  }

  activityCard(String infoTitle, IconData icon, int info) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: GestureDetector(
          onTap: (() {
            Navigator.pushNamed(context, '/history');
          }),
          child: Container(
            decoration: BoxDecoration(
              color: kLight,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            height: 85,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: kTeal,
                    size: 28,
                  ),
                  Text(
                    '$infoTitle'.toUpperCase(),
                    style: TextStyle(
                      color: kTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Count: $info',
                    style: TextStyle(
                        //color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  nextPrayer() {
    return Card(
      color: kThird,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Next Prayer'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              tileColor: kThirdLight,
              leading: nextPrayerIndex != null
                  ? Icon(Icons.access_alarm_rounded)
                  : Icon(Icons.error, color: kThird),
              title: nextPrayerIndex != null
                  ? Text('${englishNames[nextPrayerIndex]}')
                  : Text('Your connection is not stable'),
              subtitle: nextPrayerIndex != null
                  ? Text('${urduNames[nextPrayerIndex]}')
                  : Text(' '),
              trailing:
                  nextPrayerTime != null ? Text('$nextPrayerTime') : Text(' '),
            )
          ],
        ),
      ),
    );
  }

  currentPrayer() {
    return Card(
      color: kSecond,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Current Prayer'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              tileColor: kSecondLight,
              leading: currentPrayerIndex != null
                  ? Icon(Icons.access_alarm_rounded)
                  : Icon(Icons.error, color: kThird),
              title: currentPrayerIndex != null
                  ? Text('${englishNames[currentPrayerIndex]}')
                  : Text('Your connection is not stable'),
              subtitle: currentPrayerIndex != null
                  ? Text('${urduNames[currentPrayerIndex]}')
                  : Text(' '),
              trailing: currentPrayerTime != null
                  ? Text('$currentPrayerTime')
                  : Text(' '),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            body: ListView(
              children: [
                Column(
                  children: [
                    currentPrayer(),
                    Card(
                      color: kTeal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                'Recitation Activity'.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                activityCard(
                                  'Read',
                                  Icons.check_circle,
                                  readCount,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                activityCard(
                                  'Skip',
                                  Icons.error,
                                  skipCount,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                activityCard(
                                  // kThirdLight,
                                  'Absent',
                                  Icons.cancel,
                                  absentCount,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    nextPrayer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Presentation Details'.toUpperCase(),
                              style: kH2style,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 56),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(color: kGrey),
                                  ),
                                  Text(
                                    '$date',
                                    style: TextStyle(color: kTeal),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 56),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prayer Name',
                                    style: TextStyle(color: kGrey),
                                  ),
                                  Text(
                                    '$prayerName',
                                    style: TextStyle(color: kTeal),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 56),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prayer Time',
                                    style: TextStyle(color: kGrey),
                                  ),
                                  Text(
                                    '$prayerTime',
                                    style: TextStyle(color: kTeal),
                                  ),
                                ],
                              ),
                            ),
                            myturn
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      activityButton('Read', read, kLight),
                                      activityButton(
                                          'Skip', skip, kSecondLight),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: currentUser.verses.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  color: kLight,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        // 'parah',
                                        'Parah: ${parahNumber[index]}',
                                        style: TextStyle(color: kGrey),
                                      ),
                                      Text(
                                        // 'Soorah',
                                        '${surahName[index]}',
                                        style: TextStyle(color: kGrey),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        // 'verse',
                                        'Verse: ${verseNumber[index]}',
                                        style: TextStyle(color: kGrey),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Center(
                                    child: Text(
                                      '${verses[index]}',
                                      style: kVersestyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: !myturn
                                      ? Text(
                                          '${translations[index]}',
                                          style: ktranslationStyle,
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          'Translation Hidden',
                                          style: ktranslationStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : _loading();
  }

  _loading() {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
