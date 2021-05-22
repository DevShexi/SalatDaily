import 'package:flutter/material.dart';
import 'package:salatdaily/historymanager.dart';
import 'package:salatdaily/constants.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  HistoryManager historyManager = new HistoryManager();
  int skipCount = 0;
  int readCount = 0;
  int absentCount = 0;

  List skippedVerses = [];
  List skippedTranslations = [];
  List skippedVerseNumbers = [];
  List skippedSurahNames = [];
  List skippedPrayerTimes = [];
  List skippedPrayerNames = [];
  List skippedPrayerDays = [];
  List skippedPrayerDates = [];

  List readVerses = [];
  List readTranslations = [];
  List readVerseNumbers = [];
  List readSurahNames = [];
  List readPrayerTimes = [];
  List readPrayerNames = [];
  List readPrayerDays = [];
  List readPrayerDates = [];

  List absentVerses = [];
  List absentTranslations = [];
  List absentVerseNumbers = [];
  List absentSurahNames = [];
  List absentPrayerTimes = [];
  List absentPrayerNames = [];
  List absentPrayerDays = [];
  List absentPrayerDates = [];
  String skip = 'You skipped on';
  String read = 'You recited on';
  String absent = 'You were absent on';
  @override
  void initState() {
    fetchHistory();
    super.initState();
  }

  fetchHistory() async {
    await historyManager.getHistory();
    setState(() {
      skipCount = historyManager.skipCount;
      readCount = historyManager.readCount;
      absentCount = historyManager.absentCount;

      //
      ////
      //////
      ////
      //

      historyManager.skippedVerses.forEach((element) {
        skippedVerses.add(element);
      });
      historyManager.skippedTranslations.forEach((element) {
        skippedTranslations.add(element);
      });
      historyManager.skippedVerseNumbers.forEach((element) {
        skippedVerseNumbers.add(element);
      });
      historyManager.skippedSurahNames.forEach((element) {
        skippedSurahNames.add(element);
      });
      historyManager.skippedPrayerTimes.forEach((element) {
        skippedPrayerTimes.add(element);
      });
      historyManager.skippedPrayerNames.forEach((element) {
        skippedPrayerNames.add(element);
      });
      historyManager.skippedPrayerDays.forEach((element) {
        skippedPrayerDays.add(element);
      });
      historyManager.skippedPrayerDates.forEach((element) {
        skippedPrayerDates.add(element);
      });

      //
      ////
      //////
      ////
      //

      historyManager.readVerses.forEach((element) {
        readVerses.add(element);
      });
      historyManager.readTranslations.forEach((element) {
        readTranslations.add(element);
      });
      historyManager.readVerseNumbers.forEach((element) {
        readVerseNumbers.add(element);
      });
      historyManager.readSurahNames.forEach((element) {
        readSurahNames.add(element);
      });
      historyManager.readPrayerTimes.forEach((element) {
        readPrayerTimes.add(element);
      });
      historyManager.readPrayerNames.forEach((element) {
        readPrayerNames.add(element);
      });
      historyManager.readPrayerDays.forEach((element) {
        readPrayerDays.add(element);
      });
      historyManager.readPrayerDates.forEach((element) {
        readPrayerDates.add(element);
      });

      //
      ////
      //////
      ////
      //

      historyManager.absentVerses.forEach((element) {
        absentVerses.add(element);
      });
      historyManager.absentTranslations.forEach((element) {
        absentTranslations.add(element);
      });
      historyManager.absentVerseNumbers.forEach((element) {
        absentVerseNumbers.add(element);
      });
      historyManager.absentSurahNames.forEach((element) {
        absentSurahNames.add(element);
      });
      historyManager.absentPrayerTimes.forEach((element) {
        absentPrayerTimes.add(element);
      });
      historyManager.absentPrayerNames.forEach((element) {
        absentPrayerNames.add(element);
      });
      historyManager.absentPrayerDays.forEach((element) {
        absentPrayerDays.add(element);
      });
      historyManager.absentPrayerDates.forEach((element) {
        absentPrayerDates.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeal,
        title: Text(
          'Recitation History',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Container(
        // color: kLight,
        child: ListView(
          children: [
            ExpansionTile(
              leading: Icon(
                Icons.error,
                size: 36,
                color: kSecond,
              ),
              title: Text(
                'Skip'.toUpperCase(),
                style: TextStyle(color: kGrey),
              ),
              subtitle: Text(
                'Skip History',
                style: TextStyle(
                  fontSize: 10,
                  color: kGrey,
                ),
              ),
              trailing: Container(
                child: Center(
                  child: Text(
                    '$skipCount',
                    style: TextStyle(
                      color: kSecond,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: kSecondLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: kSecond),
                ),
              ),
              children: [
                skipCount != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: skipCount,
                        itemBuilder: (context, index) {
                          return _infoCard(
                              skippedVerses,
                              skippedTranslations,
                              skippedSurahNames,
                              skippedVerseNumbers,
                              skippedPrayerDays,
                              skippedPrayerDates,
                              skippedPrayerNames,
                              skippedPrayerTimes,
                              skip,
                              index,
                              kSecondLight,
                              kSecond);
                        },
                      )
                    : Card(
                        color: kLight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ListTile(
                            title: Text('Nothing Skipped'),
                            subtitle: Row(
                              children: [
                                Text('Well Done'),
                                Icon(
                                  Icons.favorite,
                                  color: kThird,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.check_circle,
                size: 36,
                color: kTeal,
              ),
              title: Text(
                'Read'.toUpperCase(),
                style: TextStyle(color: kGrey),
              ),
              subtitle: Text(
                'Recitation History',
                style: TextStyle(
                  fontSize: 10,
                  color: kGrey,
                ),
              ),
              trailing: Container(
                child: Center(
                  child: Text(
                    '$readCount',
                    style: TextStyle(
                      color: kTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: kLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: kTeal),
                ),
              ),
              children: [
                readCount != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: readCount,
                        itemBuilder: (context, index) {
                          return _infoCard(
                              readVerses,
                              readTranslations,
                              readSurahNames,
                              readVerseNumbers,
                              readPrayerDays,
                              readPrayerDates,
                              readPrayerNames,
                              readPrayerTimes,
                              read,
                              index,
                              kLight,
                              kTeal);
                        },
                      )
                    : Card(
                        color: kLight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ListTile(
                            title: Text('No Participation Yet'),
                            subtitle:
                                Text('You recitation will be listed here'),
                          ),
                        ),
                      ),
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.cancel,
                size: 36,
                color: kThird,
              ),
              title: Text(
                'Absent'.toUpperCase(),
                style: TextStyle(
                  color: kGrey,
                ),
              ),
              subtitle: Text(
                'Absent History',
                style: TextStyle(
                  fontSize: 10,
                  color: kGrey,
                ),
              ),
              trailing: Container(
                child: Center(
                  child: Text(
                    '$absentCount',
                    style:
                        TextStyle(color: kThird, fontWeight: FontWeight.bold),
                  ),
                ),
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: kThirdLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: kThird),
                ),
              ),
              children: [
                absentCount != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: absentCount,
                        itemBuilder: (context, index) {
                          return _infoCard(
                              absentVerses,
                              absentTranslations,
                              absentSurahNames,
                              absentVerseNumbers,
                              absentPrayerDays,
                              absentPrayerDates,
                              absentPrayerNames,
                              absentPrayerTimes,
                              absent,
                              index,
                              kThirdLight,
                              kThird);
                        },
                      )
                    : Card(
                        color: kLight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ListTile(
                            title: Text('Zero Absence'),
                            subtitle: Row(
                              children: [
                                Text('Well Done'),
                                Icon(
                                  Icons.favorite,
                                  color: kThird,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _infoCard(
    List verses,
    List translations,
    List surahNames,
    List verseNumbers,
    List prayerDays,
    List prayerDates,
    List prayerNames,
    List prayerTimes,
    String status,
    int index,
    color,
    borderColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: GestureDetector(
        onTap: (() {
          showGeneralDialog(
            context: context,
            barrierColor: kLight.withOpacity(0.9),
            barrierDismissible:
                true, // should dialog be dismissed when tapped outside
            barrierLabel: "Dialog", // label for barrier
            transitionDuration: Duration(
                milliseconds:
                    500), // how long it takes to popup dialog after button click
            pageBuilder: (_, __, ___) {
              // your widget implementation
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${verses[index]}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kTeal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    child: Divider(
                                      thickness: 1,
                                      color: kTeal,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${translations[index]}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${surahNames[index]}',
                                        style: TextStyle(
                                          color: kGrey,
                                          //fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'آیت نمبر: ${verseNumbers[index]}',
                                        style: TextStyle(
                                          color: kGrey,
                                          //fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ListTile(
                                //   title: Text('${verses[index]}'),
                                //   subtitle: Text('${translations[index]}'),
                                //   trailing: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text('${surahNames[index]}'),
                                //       Text('Verse: ${verseNumbers[index]}'),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  child: Text(
                                    '$status ${prayerDays[index]}, ${prayerDates[index]} at ${prayerNames[index]}, ${prayerTimes[index]}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kGrey,
                                      //fontSize: 20,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flex: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox.expand(
                            child: Center(
                              child: RaisedButton(
                                color: color,
                                child: Text('Close'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
        child: Card(
          shape: Border(
            left: BorderSide(color: borderColor, width: 5),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('${prayerDays[index]} ${prayerDates[index]}'),
              subtitle: Text('${prayerNames[index]}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${surahNames[index]}'),
                  Text('Verse: ${verseNumbers[index]}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
