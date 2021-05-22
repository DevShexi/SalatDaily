import 'package:flutter/material.dart';
import 'package:salatdaily/prayertimes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salatdaily/constants.dart';

class DailyPrayers extends StatefulWidget {
  DailyPrayers({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DailyPrayersState createState() => _DailyPrayersState();
}

class _DailyPrayersState extends State<DailyPrayers> {
  static const spinkit = SpinKitFadingCircle(
    color: kTeal,
    size: 50.0,
  );
  bool isloaded = false;
  List<String> englishNames = [
    'FAJAR',
    'SUNRISE',
    'ZUHAR',
    'ASAR',
    'MAGHRIB',
    'ISHA',
  ];
  List<String> urduNames = ['فجر', 'طلوع آفتاب', 'ظهر', 'عصر', 'مغرب', 'عشاء'];
  List<String> today = [];
  PrayerTimes prayerTimes = PrayerTimes();
  double lat;
  double lon;
  String whichMonth;
  int whichDay;
  int dayIndex;
  String whichYear;

  String weekday = ' ';
  String date = ' ';
  String month = ' ';
  String year = ' ';
  String ad = ' ';
  String islamicDate = ' ';
  String islamicMonth = ' ';
  String hijriyear = ' ';
  String ah = ' ';

  @override
  void initState() {
    fetchPrayerTimes();
    super.initState();
  }

  updateState() {
    setState(() {
      prayerTimes.times.forEach((element) {
        print(element);
        today.add(element);
      });
      weekday = prayerTimes.weekday;
      date = prayerTimes.date;
      month = prayerTimes.month;
      year = prayerTimes.year;
      ad = 'AD';

      islamicDate = prayerTimes.islamicDate;
      islamicMonth = prayerTimes.islamicMonth;
      hijriyear = prayerTimes.hijriyear;
      ah = 'AH';
      isloaded = true;
    });
  }

  fetchPrayerTimes() async {
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
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      body: SafeArea(
        child: isloaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: _dayndates(),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: _prayers(),
                    ),
                  )
                ],
              )
            : _loading(),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2021),
      // firstDate: DateTime.now().subtract(new Duration(days: 60)),
      // lastDate: DateTime.now().add(new Duration(days: 60)),
    );
    if (picked != null) {
      String date = ('${picked.toLocal()}'.split(' ')[0]);
      setState(() async {
        whichMonth = date.split('-')[1];
        print(whichMonth);

        whichDay = int.parse(date.split('-')[2]);
        dayIndex = whichDay - 1;
        whichYear = date.split('-')[0];
        print(whichDay);
        print(whichYear);
        await prayerTimes.getPrayerTimes(
            lat, lon, dayIndex, whichMonth, whichYear);
        updateState();
      });
      // await prayerTimes.getPrayerTimes(
      //     lat, lon, dayIndex, whichMonth, whichYear);
      // updateState();
    }
  }

  _loading() {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }

//The container at the top, will show current day, date-month-year and Islamic date-month-year
  _dayndates() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Column(
            children: [
              Icon(
                Icons.calendar_today,
                color: kTeal,
              ),
              Text(
                '$month $date',
                style: TextStyle(color: kGrey),
              ),
              Text(
                '$year $ad',
                style: TextStyle(color: kGrey),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              '$weekday',
              style: TextStyle(
                  color: kTeal, fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.calendar_today,
              color: kTeal,
            ),
            Text(
              '$islamicDate $islamicMonth',
              style: TextStyle(color: kGrey),
            ),
            SizedBox(),
            Text(
              '$hijriyear $ah',
              style: TextStyle(color: kGrey),
            ),
          ],
        ),
      ],
    );
  }

//The container at the bottom, will show a list of all prayes with starting time
  _prayers() {
    return ListView.builder(
      itemCount: englishNames.length,
      itemBuilder: (context, index) {
        return Card(
          //color: Colors.blueGrey[800],
          child: ListTile(
            key: new Key(index.toString()),
            leading: Icon(
              Icons.access_alarm_rounded,
              size: 32,
              color: kTeal,
            ),
            title: Text(
              '${englishNames[index]}',
              style: TextStyle(color: kTeal),
            ),
            subtitle: Text(
              '${urduNames[index]}',
              style: TextStyle(color: kGrey),
            ),
            trailing: Text(
              '${today[index]}',
              style: TextStyle(
                color: kSecond,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
