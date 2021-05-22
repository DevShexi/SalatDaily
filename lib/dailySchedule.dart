import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:salatdaily/constants.dart';

class DailySchedule {
  String jwtToken;
  List<String> prayers = [];
  List<String> reciters = [];
  List<String> statusID = [];
  List<List<String>> surahName = [
    [],
    [],
    [],
  ];
  List<List<int>> verseNumber = [
    [],
    [],
    [],
  ];
  List<List<String>> verses = [
    [],
    [],
    [],
  ];
  List<List<String>> translations = [
    [],
    [],
    [],
  ];
  List scheduleVerses;
  List user1;
  List user2;
  List user3;

  Future<bool> updateStatus() async {
    final String statusUpdateUrl = '$kBaseUrl/api/v1/update-status';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    try {
      final http.Response response = await http.post(
        statusUpdateUrl,
        headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
        body: <String, String>{'status_id': 'read'},
      );
      if (response.statusCode == 200) {
        print('Recitation Status has been Updated successfully');
        return true;
      } else {
        print('Recitation Status Update Failed');
        return false;
      }
    } catch (e) {
      print('Exception Caused while updating Status: $e');
      return false;
    }
  }

  Future getSchedule() async {
    String url = '$kBaseUrl/api/v1/daily-schedule';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    try {
      http.Response response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
      );
      String dailyScheduleResponse = response.body;

      var decodeData = jsonDecode(dailyScheduleResponse);
      scheduleVerses = decodeData['schedule-verses'];

      prayers.add(scheduleVerses[0]['prayer_name']);
      prayers.add(scheduleVerses[1]['prayer_name']);
      prayers.add(scheduleVerses[2]['prayer_name']);
      // print(prayers);

      reciters.add(scheduleVerses[0]['first_name']);
      reciters.add(scheduleVerses[1]['first_name']);
      reciters.add(scheduleVerses[2]['first_name']);
      //print(reciters);
      try {
        user1 = scheduleVerses[0]['surah_verse'];
        user1.forEach((element) {
          verses[0].add(element['verse']);
          surahName[0].add(element['surah_name']);
          verseNumber[0].add(element['verse_num']);
          translations[0].add(element['translation']);
        });
        user2 = scheduleVerses[1]['surah_verse'];
        user2.forEach((element) {
          verses[1].add(element['verse']);
          surahName[1].add(element['surah_name']);
          verseNumber[1].add(element['verse_num']);
          translations[1].add(element['translation']);
        });
        user3 = scheduleVerses[2]['surah_verse'];
        user3.forEach((element) {
          verses[2].add(element['verse']);
          surahName[2].add(element['surah_name']);
          verseNumber[2].add(element['verse_num']);
          translations[2].add(element['translation']);
        });
      } catch (e) {
        print('OOOOOPPPPSSSSSSS: $e');
      }

      statusID.add(scheduleVerses[0]['status_id']);
      statusID.add(scheduleVerses[1]['status_id']);
      statusID.add(scheduleVerses[2]['status_id']);
    } catch (e) {
      print('Exception in Daily Schedule: $e');
    }
  }
}
