import 'dart:collection';

import 'package:salatdaily/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class HistoryManager {
  int skipCount = 0;
  int readCount = 0;
  int absentCount = 0;
  Map<String, Map<String, Object>> dumyResponse = {
    "schedule-verse": {
      "skip_count": 2,
      "skip": [
        {
          "username": null,
          "user_id": null,
          "updated_at": "2020-10-12T15:46:24.000000+00:00",
          "surah_verse": [
            {
              "verse_num": 6,
              "verse": "مِنَ ٱلۡجِنَّةِ وَٱلنَّاسِ",
              "translation": "وہ جنّات میں سے (ہو) یا انسانوں میں سے",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            }
          ],
          "status_id": "skip",
          "status": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "status",
            "__cardinality__": "one"
          },
          "prayer_time": "17:37:00",
          "prayer_name": "Maghrib",
          "prayer_day": "Monday",
          "prayer_date": "2020-10-12",
          "inserted_at": "2020-10-10T11:04:03.000000+00:00",
          "id": 6,
          "customer_id": 1,
          "customer": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "customer",
            "__cardinality__": "one"
          },
          "app_name": null,
          "active_button": false,
          "__meta__": {
            "state": "loaded",
            "source": "schedule_verses",
            "schema": "Elixir.Core.V1.ScheduleVerseModel",
            "prefix": null,
            "context": null
          }
        },
        {
          "username": null,
          "user_id": null,
          "updated_at": "2020-10-12T15:46:24.000000+00:00",
          "surah_verse": [
            {
              "verse_num": 6,
              "verse": "مِنَ ٱلۡجِنَّةِ وَٱلنَّاسِ",
              "translation": "وہ جنّات میں سے (ہو) یا انسانوں میں سے",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            }
          ],
          "status_id": "skip",
          "status": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "status",
            "__cardinality__": "one"
          },
          "prayer_time": "17:37:00",
          "prayer_name": "Maghrib",
          "prayer_day": "Monday",
          "prayer_date": "2020-10-12",
          "inserted_at": "2020-10-10T11:04:03.000000+00:00",
          "id": 6,
          "customer_id": 1,
          "customer": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "customer",
            "__cardinality__": "one"
          },
          "app_name": null,
          "active_button": false,
          "__meta__": {
            "state": "loaded",
            "source": "schedule_verses",
            "schema": "Elixir.Core.V1.ScheduleVerseModel",
            "prefix": null,
            "context": null
          }
        }
      ],
      "read_count": 3,
      "read": [
        {
          "username": null,
          "user_id": null,
          "updated_at": "2020-10-15T05:59:16.000000+00:00",
          "surah_verse": [
            {
              "verse_num": 1,
              "verse": "قُلۡ أَعُوذُ بِرَبِّ ٱلنَّاسِ",
              "translation": "کہو کہ میں لوگوں کے پروردگار کی پناہ مانگتا ہوں",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            },
            {
              "verse_num": 6,
              "verse": "مِنَ ٱلۡجِنَّةِ وَٱلنَّاسِ",
              "translation": "وہ جنّات میں سے (ہو) یا انسانوں میں سے",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            },
            {
              "verse_num": 5,
              "verse": "وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ",
              "translation": "اور حسد کرنے والے کی برائی سے جب حسد کرنے لگے",
              "surah_num": 113,
              "surah_name": "سُورَةُ الفَلَقِ",
              "parah_num": 30
            }
          ],
          "status_id": "read",
          "status": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "status",
            "__cardinality__": "one"
          },
          "prayer_time": "15:55:00",
          "prayer_name": "Asr",
          "prayer_day": "Wednesday",
          "prayer_date": "2020-10-14",
          "inserted_at": "2020-10-12T15:46:25.000000+00:00",
          "id": 11,
          "customer_id": 1,
          "customer": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "customer",
            "__cardinality__": "one"
          },
          "app_name": null,
          "active_button": false,
          "__meta__": {
            "state": "loaded",
            "source": "schedule_verses",
            "schema": "Elixir.Core.V1.ScheduleVerseModel",
            "prefix": null,
            "context": null
          }
        }
      ],
      "absent_count": 2,
      "absent": [
        {
          "username": null,
          "user_id": null,
          "updated_at": "2020-10-12T15:46:24.000000+00:00",
          "surah_verse": [
            {
              "verse_num": 6,
              "verse": "مِنَ ٱلۡجِنَّةِ وَٱلنَّاسِ",
              "translation": "وہ جنّات میں سے (ہو) یا انسانوں میں سے",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            }
          ],
          "status_id": "absent",
          "status": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "status",
            "__cardinality__": "one"
          },
          "prayer_time": "17:37:00",
          "prayer_name": "Maghrib",
          "prayer_day": "Monday",
          "prayer_date": "2020-10-12",
          "inserted_at": "2020-10-10T11:04:03.000000+00:00",
          "id": 6,
          "customer_id": 1,
          "customer": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "customer",
            "__cardinality__": "one"
          },
          "app_name": null,
          "active_button": false,
          "__meta__": {
            "state": "loaded",
            "source": "schedule_verses",
            "schema": "Elixir.Core.V1.ScheduleVerseModel",
            "prefix": null,
            "context": null
          }
        },
        {
          "username": null,
          "user_id": null,
          "updated_at": "2020-10-10T11:04:01.000000+00:00",
          "surah_verse": [
            {
              "verse_num": 1,
              "verse": "قُلۡ أَعُوذُ بِرَبِّ ٱلنَّاسِ",
              "translation": "کہو کہ میں لوگوں کے پروردگار کی پناہ مانگتا ہوں",
              "surah_num": 114,
              "surah_name": "سُورَةُ النَّاسِ",
              "parah_num": 30
            }
          ],
          "status_id": "absent",
          "status": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "status",
            "__cardinality__": "one"
          },
          "prayer_time": "11:52:00",
          "prayer_name": "Dhuhr",
          "prayer_day": "Saturday",
          "prayer_date": "2020-10-10",
          "inserted_at": "2020-10-08T14:19:27.000000+00:00",
          "id": 1,
          "customer_id": 1,
          "customer": {
            "__owner__": "Elixir.Core.V1.ScheduleVerseModel",
            "__field__": "customer",
            "__cardinality__": "one"
          },
          "app_name": null,
          "active_button": false,
          "__meta__": {
            "state": "loaded",
            "source": "schedule_verses",
            "schema": "Elixir.Core.V1.ScheduleVerseModel",
            "prefix": null,
            "context": null
          }
        }
      ]
    }
  };

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

  Future getHistory() async {
    String url = '$kBaseUrl/api/v1/history';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    http.Response response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
    );
    String historyResponse = response.body;
    var decodeData = json.decode(historyResponse);
    try {
      List skip = decodeData['schedule-verse']['skip'];
      skipCount = decodeData['schedule-verse']['skip_count'];
      skip.forEach((element) {
        skippedVerses.add(element['surah_verse'][0]['verse']);
        skippedTranslations.add(element['surah_verse'][0]['translation']);
        skippedVerseNumbers.add(element['surah_verse'][0]['verse_num']);
        skippedSurahNames.add(element['surah_verse'][0]['surah_name']);
        skippedPrayerDates.add(
          DateFormat.yMMMMd().format(
            DateTime.parse(element['prayer_date']),
          ),
        );
        skippedPrayerDays.add(element['prayer_day']);
        skippedPrayerNames.add(element['prayer_name']);
        skippedPrayerTimes.add(
          (DateFormat.jm().format(
            DateFormat("hh:mm")
                .parse('${element['prayer_time'].split(' ')[0]}'),
          )),
        );
      });

      List read = decodeData['schedule-verse']['read'];
      readCount = decodeData['schedule-verse']['read_count'];

      read.forEach(
        (element) {
          for (int i = 0; i < element['surah_verse'].length; i++) {
            readVerses.add(element['surah_verse'][i]['verse']);
            readTranslations.add(element['surah_verse'][i]['translation']);
            readVerseNumbers.add(element['surah_verse'][i]['verse_num']);
            readSurahNames.add(element['surah_verse'][i]['surah_name']);
            readPrayerDates.add(
              DateFormat.yMMMMd().format(
                DateTime.parse(element['prayer_date']),
              ),
            );
            readPrayerDays.add(element['prayer_day']);
            readPrayerNames.add(element['prayer_name']);
            readPrayerTimes.add(
              (DateFormat.jm().format(
                DateFormat("hh:mm")
                    .parse('${element['prayer_time'].split(' ')[0]}'),
              )),
            );
          }
        },
      );

      List absent = decodeData['schedule-verse']['absent'];
      absentCount = decodeData['schedule-verse']['absent_count'];
      absent.forEach(
        (element) {
          absentVerses.add(element['surah_verse'][0]['verse']);
          absentTranslations.add(element['surah_verse'][0]['translation']);
          absentVerseNumbers.add(element['surah_verse'][0]['verse_num']);
          absentSurahNames.add(element['surah_verse'][0]['surah_name']);
          absentPrayerDates.add(
            DateFormat.yMMMMd().format(
              DateTime.parse(element['prayer_date']),
            ),
          );
          absentPrayerDays.add(element['prayer_day']);
          absentPrayerNames.add(element['prayer_name']);
          absentPrayerTimes.add(
            (DateFormat.jm().format(
              DateFormat("hh:mm")
                  .parse('${element['prayer_time'].split(' ')[0]}'),
            )),
          );
        },
      );
    } catch (e) {
      print('Exception while Fetching History: $e');
    }
  }
}
