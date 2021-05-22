import 'package:flutter/material.dart';
import 'package:salatdaily/dailySchedule.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salatdaily/constants.dart';

class Recitation extends StatefulWidget {
  @override
  _RecitationState createState() => _RecitationState();
}

class _RecitationState extends State<Recitation> {
  DailySchedule dailySchedule = new DailySchedule();
  static const spinkit = SpinKitFadingCircle(
    color: kTeal,
    size: 50.0,
  );
  bool isLoaded = false;
  List<String> statusID = []; // read or skipped
  List<String> prayers = []; // like zuhar, Asar, Maghrib
  List<String> reciters = []; //name of the person whos turn is to recite.

  List<List<String>> surahName = [
    [],
    [],
    [],
  ]; //name of surah like fatiha to recite
  List<List<int>> verseNumber = [
    [],
    [],
    [],
  ];

  List<List<String>> verses = [
    [],
    [],
    [],
  ]; //arabic textual verse that will be shown
  List<List<String>> translations = [
    [],
    [],
    [],
  ]; //translation of the verses
  @override
  void initState() {
    super.initState();
    fetchDailySchedule();
  }

  fetchDailySchedule() async {
    await dailySchedule.getSchedule();

    setState(() {
      dailySchedule.prayers.forEach((element) {
        prayers.add(element);
      });

      dailySchedule.reciters.forEach((element) {
        reciters.add(element);
      });

      dailySchedule.surahName[0].forEach((element) {
        surahName[0].add(element);
      });
      dailySchedule.surahName[1].forEach((element) {
        surahName[1].add(element);
      });
      dailySchedule.surahName[2].forEach((element) {
        surahName[2].add(element);
      });

      dailySchedule.verseNumber[0].forEach((element) {
        verseNumber[0].add(element);
      });
      dailySchedule.verseNumber[1].forEach((element) {
        verseNumber[1].add(element);
      });
      dailySchedule.verseNumber[2].forEach((element) {
        verseNumber[2].add(element);
      });

      dailySchedule.verses[0].forEach((element) {
        verses[0].add(element);
      });
      dailySchedule.verses[1].forEach((element) {
        verses[1].add(element);
      });
      dailySchedule.verses[2].forEach((element) {
        verses[2].add(element);
      });

      dailySchedule.translations[0].forEach((element) {
        translations[0].add(element);
      });
      dailySchedule.translations[1].forEach((element) {
        translations[1].add(element);
      });
      dailySchedule.translations[2].forEach((element) {
        translations[2].add(element);
      });

      dailySchedule.statusID.forEach((element) {
        statusID.add(element);
      });

      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            //backgroundColor: kLight,
            body: SafeArea(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Card(
                      color: kLight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: verses[index].length,
                                itemBuilder: (context, index2) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: kLightGrey,
                                        //width: double.infinity,
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${prayers[index]}'.toUpperCase(),
                                              style: kTealTextStyle,
                                            ),
                                            Text(
                                              '${surahName[index][index2]}',
                                              style: kTealTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'Verse: ${verseNumber[index][index2]}',
                                              style: kTealTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 5),
                                        child: Center(
                                          child: Text(
                                            '${verses[index][index2]}',
                                            style: kVersestyle,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Center(
                                          child: Text(
                                            '${translations[index][index2]}',
                                            style: ktranslationStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 30,
                                      //   child: Divider(
                                      //     color: Colors.blueGrey[700],
                                      //     thickness: 1.67,
                                      //   ),
                                      // ),
                                    ],
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.account_box_sharp,
                                      size: 30,
                                      color: kGrey,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${reciters[index]}'.toUpperCase(),
                                      style: TextStyle(
                                        color: kGrey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Status :',
                                      //style: ktextstyle,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${statusID[index]}'.toUpperCase(),
                                      style: statusStyle(statusID[index]),
                                    ),
                                    SizedBox(width: 10),
                                    statusID[index] == 'absent'
                                        ? Icon(
                                            Icons.remove_circle,
                                            color: kThird,
                                          )
                                        : SizedBox(
                                            child: statusID[index] == 'read'
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: kTeal,
                                                  )
                                                : Icon(
                                                    Icons.error,
                                                    color: kSecond,
                                                  ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ), ////////
                    ),
                  );
                },
              ),
            ),
          )
        : _loading();
  }

  statusStyle(String status) {
    if (status == 'absent') {
      return TextStyle(
        color: kThird,
        fontWeight: FontWeight.bold,
      );
    }
    if (status == 'un-read') {
      return TextStyle(
        color: kSecond,
        fontWeight: FontWeight.bold,
      );
    }
    if (status == 'read') {
      return TextStyle(
        color: kTeal,
        fontWeight: FontWeight.bold,
      );
    }
  }

  _loading() {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}

// return Padding(
//   padding: const EdgeInsets.all(10),
//   child: Card(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           color: Colors.blueGrey[800],
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${prayers[index]}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   '${reciters[index]}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   '${surahName[index]}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   '${verseNumber[index]}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text(
//             '${verses[index]}',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueGrey[800]),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             '${translations[index]}',
//             style: TextStyle(color: Colors.teal),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               RaisedButton(
//                 child: Text('Recited'),
//                 color: Colors.teal[300],
//                 onPressed: () {
//                   print('Recited the verse');
//                 },
//               ),
//               RaisedButton(
//                 child: Text('Skipped'),
//                 color: Colors.red[300],
//                 onPressed: () {
//                   print('Recited the verse');
//                 },
//               ),
//               RaisedButton(
//                 child: Text('Translation'),
//                 color: Colors.amber[300],
//                 onPressed: () {
//                   print('Recited the verse');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
